//
#include "drTreeNode.h"

DR_BEGIN

DR_RESULT drTreeNodeEnumPreOrder(drITreeNode* node, drTreeNodeEnumProc proc, void* param)
{    
    DR_RESULT ret = TREENODE_PROC_RET_CONTINUE;

    if(node == 0)
        goto __ret;

    ret = (*proc)(node, param);

    if(ret == TREENODE_PROC_RET_ABORT)
        goto __ret;

    if(ret == TREENODE_PROC_RET_IGNORECHILDREN)
        goto __addr_enum_sibling;


    if((ret = drTreeNodeEnumPreOrder(node->GetChild(), proc, param)) == TREENODE_PROC_RET_ABORT)
        goto __ret;

__addr_enum_sibling:
    if((ret = drTreeNodeEnumPreOrder(node->GetSibling(), proc, param)) == TREENODE_PROC_RET_ABORT)
        goto __ret;

__ret:
    return ret;
}
DR_RESULT drTreeNodeEnumInOrder(drITreeNode* node, drTreeNodeEnumProc proc, void* param)
{
    DR_RESULT ret = TREENODE_PROC_RET_CONTINUE;

    if(node == 0)
        goto __ret;

    if((ret = drTreeNodeEnumInOrder(node->GetChild(), proc, param)) == TREENODE_PROC_RET_ABORT)
        goto __ret;

    ret = (*proc)(node, param);

    if(ret == TREENODE_PROC_RET_ABORT)
        goto __ret;

    if((ret = drTreeNodeEnumInOrder(node->GetSibling(), proc, param)) == TREENODE_PROC_RET_ABORT)
        goto __ret;

__ret:
    return ret;
}
DR_RESULT drTreeNodeEnumPostOrder(drITreeNode* node, drTreeNodeEnumProc proc, void* param)
{
    DR_RESULT ret = TREENODE_PROC_RET_CONTINUE;

    if(node == 0)
        goto __ret;

    if((ret = drTreeNodeEnumPostOrder(node->GetChild(), proc, param)) == TREENODE_PROC_RET_ABORT)
        goto __ret;

    if((ret = drTreeNodeEnumPostOrder(node->GetSibling(), proc, param)) == TREENODE_PROC_RET_ABORT)
        goto __ret;

    ret = (*proc)(node, param);

__ret:
    return ret;
}

DR_RESULT drTreeNodeEnumPreOrder_Ignre(drITreeNode* node, drTreeNodeEnumProc proc, void* param)
{    
	DR_RESULT ret = TREENODE_PROC_RET_CONTINUE;

	if(node == 0)
		goto __ret;

	if( param )
	{
		IgnoreStruct* pIS = (IgnoreStruct*) param;
		for( int Index = 0; Index < MAX_IGNORE_NODES; Index ++ )
		{
			if( !pIS->nodes[Index] )
				break;

			if( pIS->nodes[Index] && pIS->nodes[Index] == node )
				goto ignore;
		}
	}
	
	ret = (*proc)(node, NULL );

ignore:
	if(ret == TREENODE_PROC_RET_ABORT)
		goto __ret;

	if(ret == TREENODE_PROC_RET_IGNORECHILDREN)
		goto __addr_enum_sibling;


	if((ret = drTreeNodeEnumPreOrder_Ignre(node->GetChild(), proc, param)) == TREENODE_PROC_RET_ABORT)
		goto __ret;

__addr_enum_sibling:
	if((ret = drTreeNodeEnumPreOrder_Ignre(node->GetSibling(), proc, param)) == TREENODE_PROC_RET_ABORT)
		goto __ret;

__ret:
	return ret;
}


// drTreeNode
DR_STD_ILELEMENTATION(drTreeNode)

drTreeNode::drTreeNode()
: _data(0), _parent(0), _child(0), _sibling(0)
{
}

drTreeNode::~drTreeNode()
{
}

DR_RESULT drTreeNode::EnumTree(drTreeNodeEnumProc proc, void* param, DWORD enum_type)
{
    DR_RESULT ret = DR_RET_FAILED;

    switch(enum_type)
    {
    case TREENODE_PROC_PREORDER:
        ret = drTreeNodeEnumPreOrder(this, proc, param);
        break;
    case TREENODE_PROC_INORDER:
        ret = drTreeNodeEnumInOrder(this, proc, param);
        break;
    case TREENODE_PROC_POSTORDER:
        ret = drTreeNodeEnumPostOrder(this, proc, param);
        break;
	 case TREENODE_PROC_PREORDER_IGNORE:
		 ret = drTreeNodeEnumPreOrder_Ignre(this, proc, param);
		 break;
    default:
        goto __ret;
    }

__ret:
    return ret;
}

DR_RESULT drTreeNode::InsertChild(drITreeNode* prev_node, drITreeNode* node)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(prev_node == 0)
    {
        if(_child == 0)
        {
            _child = node;
        }
        else
        {
            drITreeNode* p = _child;
            drITreeNode* s;
            while((s = p->GetSibling()))
                p = s;
            p->SetSibling(node);
        }
        node->SetSibling(0);
    }
    else
    {
        // no child list
        if(_child == 0)
            goto __ret;

        if(_child == prev_node)
        {
            _child = node;
        }
        else
        {
            drITreeNode* p = _child;
            drITreeNode* s = p->GetSibling();
            while(s && s != prev_node)
            {
                p = s;
                s = s->GetSibling();
            }

            // cannot find this prev_node
            if(s == 0)
                goto __ret;

            p->SetSibling(node);
        }

        // sibling of current node will be replaced with prev_node
        node->SetSibling(prev_node);
    }

    node->SetParent(this);

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drTreeNode::RemoveChild(drITreeNode* node)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_child == 0)
        goto __ret;

    if(_child == node)
    {
        _child = node->GetSibling();
        node->SetSibling(0);
    }
    else
    {
        drITreeNode* p = _child;
        drITreeNode* s = p->GetSibling();
        while(s && s != node)
        {
            p = s;
            s = s->GetSibling();
        }

        // cannnot find this node
        if(s == 0)
            goto __ret;

        p->SetSibling(node->GetSibling());
    }

    node->SetParent(0);
    node->SetSibling(0);

    ret = DR_RET_OK;
__ret:
    return ret;
}

//DR_RESULT drTreeNode::InsertNode(drITreeNode* parent_node, drITreeNode* node)
//{
//    DR_RESULT ret = DR_RET_FAILED;
//
//    // insert to last child node
//    if(parent_node == 0)
//    {
//        if(_child == 0)
//        {
//            _child = node;
//            node->SetParent(this);
//        }
//        else
//        {
//            drITreeNode* p = _child;
//            drITreeNode* s;
//            while((s = p->GetSibling()))
//                p = s;
//
//            p->SetChild(node);
//            node->SetParent(p);
//        }
//    }
//    else
//    {
//        // find parent node
//        drITreeNode* p = FindNode(parent_node);
//        if(p == 0)
//            goto __ret;
//
//        if(DR_FAILED(p->InsertNode(0, node)))
//            goto __ret;
//    }
//
//    ret = DR_RET_OK;
//__ret:
//    return ret;
//}
//DR_RESULT drTreeNode::RemoveNode(drITreeNode* node)
//{
//    // reset parent, child, sibling node
//    DR_RESULT ret = DR_RET_FAILED;
//
//    drITreeNode* p = FindNode(node);
//    if(p == 0)
//        goto __ret;
//
//    drITreeNode* pp = p->GetParent();
//
//    // remove root node
//    if(pp == 0)
//    {
//        assert(pp == this && "invalid tree node hierachy");
//    }
//    // remove non-root node
//    else
//    {
//        drITreeNode* new_sibling = p->GetSibling();
//        drITreeNode* pp_child = pp->GetChild();
//        // p is first child node
//        if(pp_child == p)
//        {
//            pp->SetChild(new_sibling);            
//        }
//        // p is non-first child node
//        else
//        {
//            drITreeNode* z = pp_child->GetSibling();
//            while(z != p)
//            {
//                pp_child = z;
//                z = z->GetSibling();
//            }
//
//            pp_child->SetSibling(new_sibling);
//        }
//        
//    }
//
//    drITreeNode* x = p->GetChild();
//    x->SetParent(pp);
//    while((x = x->GetSibling()))
//    {
//        x->SetParent(pp);
//    }
//
//    ret = DR_RET_OK;
//__ret:
//    return ret;
//}

drITreeNode* drTreeNode::FindNode(drITreeNode* node)
{
    drITreeNode* ret = 0;

    if(this == node)
    {
        ret = this;
        goto __ret;
    }

    if(_child)
    {
        if(ret = _child->FindNode(node))
            goto __ret;
    }

    if(_sibling)
    {
        if(ret = _sibling->FindNode(node))
            goto __ret;
    }

__ret:
    return ret;
}
drITreeNode* drTreeNode::FindNode(void* data)
{
    drITreeNode* ret = 0;

    if(_data == data)
    {
        ret = this;
        goto __ret;
    }

    if(_child)
    {
        if(ret = _child->FindNode(data))
            goto __ret;
    }

    if(_sibling)
    {
        if(ret = _sibling->FindNode(data))
            goto __ret;
    }

__ret:
    return ret;
}
DWORD drTreeNode::GetNodeNum() const
{
    DWORD ret = 1;

    if(_child)
    {
        ret += _child->GetNodeNum();
    }

    if(_sibling)
    {
        ret += _sibling->GetNodeNum();
    }

    return ret;
}

drITreeNode* drTreeNode::GetChild(DWORD id)
{
    drITreeNode* ret = 0;


    if(id == 0)
    {
        ret = _child;
        goto __ret;
    }

    if(_child == 0)
        goto __ret;

    DWORD num = 1;

    drITreeNode* c = _child->GetSibling();
    while(c)
    {
        if(id == num)
        {
            ret = c;
            goto __ret;
        }

        num += 1;
        c = c->GetSibling();
    }

__ret:
    return ret;

}

DWORD drTreeNode::GetChildNum() const
{
    DWORD num = 0;
    if(_child == 0)
        goto __ret;

    num = 1;

    drITreeNode* c = _child->GetSibling();
    while(c)
    {
        num += 1;
        c = c->GetSibling();
    }

__ret:
    return num;
}

DWORD drTreeNode::GetDepthLevel() const
{
    DWORD d = 0;

    drITreeNode* parent = _parent;

    while(parent)
    {
        d += 1;
        parent = parent->GetParent();
    }

    return d;
}

DR_END
