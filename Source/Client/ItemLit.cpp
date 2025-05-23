//
#include "stdafx.h"
#include "ItemLit.h"

lwItemLit::lwItemLit()
{
}
lwItemLit::~lwItemLit()
{
  Clear();
}
lwItemLit::_ItemBuf_It lwItemLit::_FindItemWithId(DWORD id)
{
  _ItemBuf_It it   = _item.begin();
  _ItemBuf_It it_e = _item.end();

  for(; it != it_e; ++it)
  {
	if((*it)->id == id)
	  break;
  }
  return it;
}
DR_RESULT lwItemLit::Clear()
{
  if(_item.size() > 0)
  {
	_ItemBuf_It it	 = _item.begin();
	_ItemBuf_It it_e = _item.end();

	for(; it != it_e; ++it)
	{
	  DR_DELETE((*it));
	}
	_item.clear();
  }

  return DR_RET_OK;
}
DR_RESULT lwItemLit::Load(const char* file)
{
  DR_RESULT ret = DR_RET_FAILED;

  drIFile*			fp = 0;
  lwItemLitFileHead head;
  DWORD				i, j;
  DWORD				lit_num;
  DWORD				item_num;
  lwItemLitInfo*	item_info = 0;
  lwLitInfo*		lit_info  = 0;

  DR_FAILED_RET(drGUIDCreateObject((lxvoid**)&fp, DR_GUID_FILE));
  DR_ZERO_RET(fp);
  DR_FAILED_RET(fp->CreateFile(file, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING));

  DR_FAILED_RET(fp->Read(&head, sizeof(head), 0));
  DR_FAILED_RET(fp->Read(&item_num, sizeof(item_num), 0));
  _item.reserve(item_num);

  for(i = 0; i < item_num; i++)
  {
	item_info = DR_NEW(lwItemLitInfo);
	DR_FAILED_RET(fp->Read(&item_info->id, sizeof(item_info->id), 0));
	DR_FAILED_RET(fp->Read(&item_info->descriptor, sizeof(item_info->descriptor), 0));
	DR_FAILED_RET(fp->Read(&item_info->file, sizeof(item_info->file), 0));
	DR_FAILED_RET(fp->Read(&lit_num, sizeof(lit_num), 0));
	item_info->lit.reserve(lit_num);
	for(j = 0; j < lit_num; j++)
	{
	  lit_info = DR_NEW(lwLitInfo);
	  DR_FAILED_RET(fp->Read(lit_info, sizeof(lwLitInfo), 0));
	  lit_info->id = j;
	  item_info->lit.push_back(lit_info);
	  lit_info = 0;
	}
	item_info->id = i;
	_item.push_back(item_info);
	item_info = 0;
  }

  ret = DR_RET_OK;
__ret:
  DR_IF_RELEASE(fp);
  DR_IF_DELETE(item_info);
  DR_IF_DELETE(lit_info);
  return ret;
}
DR_RESULT lwItemLit::Save(const char* file)
{
  DR_RESULT ret = DR_RET_FAILED;

  drIFile*			fp = 0;
  lwItemLitFileHead head;
  DWORD				i, j;
  DWORD				lit_num;
  DWORD				item_num;
  lwItemLitInfo*	item_info;
  lwLitInfo*		lit_info;

  DR_FAILED_RET(drGUIDCreateObject((lxvoid**)&fp, DR_GUID_FILE));
  DR_ZERO_RET(fp);
  DR_FAILED_RET(fp->CreateFile(file, GENERIC_WRITE, FILE_SHARE_READ, NULL, CREATE_ALWAYS));

  memset(&head, 0, sizeof(head));
  head.version = 1L;
  head.type	   = 1;
  DR_FAILED_RET(fp->Write(&head, sizeof(head), 0));
  item_num = (DWORD)_item.size();
  DR_FAILED_RET(fp->Write(&item_num, sizeof(item_num), 0));

  for(i = 0; i < item_num; i++)
  {
	item_info = _item[i];
	DR_FAILED_RET(fp->Write(&item_info->id, sizeof(item_info->id), 0));
	DR_FAILED_RET(fp->Write(&item_info->descriptor, sizeof(item_info->descriptor), 0));
	DR_FAILED_RET(fp->Write(&item_info->file, sizeof(item_info->file), 0));
	lit_num = (DWORD)item_info->lit.size();
	DR_FAILED_RET(fp->Write(&lit_num, sizeof(lit_num), 0));
	for(j = 0; j < lit_num; j++)
	{
	  lit_info = item_info->lit[j];
	  DR_FAILED_RET(fp->Write(lit_info, sizeof(lwLitInfo), 0));
	  lit_info = 0;
	}
	item_info = 0;
  }

  ret = DR_RET_OK;
__ret:
  DR_IF_RELEASE(fp);
  return ret;
}
DR_RESULT lwItemLit::GetItemNum(DWORD* num)
{
  DR_SIMPLE_IF_GET(num, (DWORD)_item.size());
  return DR_RET_OK;
}
DR_RESULT lwItemLit::GetItemWithId(DWORD id, lwItemLitInfo** info)
{
  if(id >= (DWORD)_item.size())
	return DR_RET_FAILED;

  DR_SIMPLE_IF_GET(info, _item[id]);
  return DR_RET_OK;
}

DR_RESULT lwItemLit::FindItem(DWORD id, lwItemLitInfo** info)
{
  _ItemBuf_It it = _FindItemWithId(id);
  if(it == _item.end())
	return DR_RET_FAILED;

  DR_SIMPLE_IF_GET(info, (*it));

  return DR_RET_OK;
}
DR_RESULT lwItemLit::AddItem(DWORD id, const char* desc, lwItemLitInfo** ret_info)
{
  DR_RESULT		 ret = DR_RET_FAILED;
  lwItemLitInfo* info;

  if(desc == 0)
	goto __ret;

  if(_FindItemWithId(id) != _item.end())
	goto __ret;

  info	   = DR_NEW(lwItemLitInfo);
  info->id = id;
  //_tcscpy(info->descriptor, desc);
  strncpy_s(info->descriptor, sizeof(info->descriptor), desc, _TRUNCATE);
  _item.push_back(info);

  DR_SIMPLE_IF_GET(ret_info, info);

  ret = DR_RET_OK;
__ret:
  return ret;
}
DR_RESULT lwItemLit::RemoveItem(DWORD item_id)
{
  DR_RESULT ret = DR_RET_FAILED;

  _ItemBuf_It it = _FindItemWithId(item_id);
  if(it == _item.end())
	goto __ret;

  DR_DELETE((*it));
  _item.erase(it);

  ret = DR_RET_OK;
__ret:
  return ret;
}
DR_RESULT lwItemLit::RemoveItemLit(DWORD item_id, DWORD lit_id)
{
  DR_RESULT					ret = DR_RET_FAILED;
  lwItemLitInfo*			item_info;
  DWORD						i, j;
  _ItemBuf_It				it;
  lwItemLitInfo::_LitBuf_It lit_it;

  it = _FindItemWithId(item_id);
  if(it == _item.end())
	goto __ret;

  item_info = (*it);
  lit_it	= item_info->FindLitWithId(lit_id);
  if(lit_it == item_info->lit.end())
	goto __ret;

  item_info->lit.erase(lit_it);

  j = (DWORD)item_info->lit.size();
  for(i = 0; i < j; i++)
  {
	item_info->lit[i]->id = i;
  }

  ret = DR_RET_OK;
__ret:
  return ret;
}
