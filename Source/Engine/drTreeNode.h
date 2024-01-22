//
#pragma once

#include "drHeader.h"
#include "drMath.h"
#include "drITypes.h"
#include "drInterfaceExt.h"

DR_BEGIN


class drTreeNode : public drITreeNode
{
    DR_STD_DECLARATION()
private:
    void* _data;
    drITreeNode* _parent;
    drITreeNode* _child;
    drITreeNode* _sibling; // root node has not sibling

public:
    drTreeNode();
    ~drTreeNode();

    DR_RESULT EnumTree(drTreeNodeEnumProc proc, void* param, DWORD enum_type);
    DR_RESULT InsertChild(drITreeNode* prev_node, drITreeNode* node);
    DR_RESULT RemoveChild(drITreeNode* node);
    drITreeNode* FindNode(drITreeNode* node);
    drITreeNode* FindNode(void* data);
    void SetParent(drITreeNode* node) { _parent = node; }
    void SetChild(drITreeNode* node) { _child = node; }
    void SetSibling(drITreeNode* node) { _sibling = node; }
    void SetData(void* data) { _data = data; }
    drITreeNode* GetParent() { return _parent; }
    drITreeNode* GetChild() { return _child; }
    drITreeNode* GetChild(DWORD id);
    drITreeNode* GetSibling() { return _sibling; }
    void* GetData() { return _data; }
    DWORD GetNodeNum() const;
    DWORD GetChildNum() const;
    DWORD GetDepthLevel() const;
};

DR_END
