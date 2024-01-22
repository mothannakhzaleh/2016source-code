//
#pragma once

struct lwLitInfo
{
  DWORD id;
  char	file[DR_MAX_FILE];
  DWORD anim_type;
  DWORD transp_type;
  float opacity;
};

struct lwItemLitInfo
{
  typedef vector<lwLitInfo*> _LitBuf;
  typedef _LitBuf::iterator	 _LitBuf_It;

  lwItemLitInfo()
  {
	id			  = 0;
	descriptor[0] = '\0';
	file[0]		  = '\0';
  }
  ~lwItemLitInfo()
  {
	_LitBuf_It it	= lit.begin();
	_LitBuf_It it_e = lit.end();
	for(; it != it_e; ++it)
	{
	  DR_DELETE((*it));
	}
  }

  _LitBuf_It FindLitWithId(DWORD id)
  {
	_LitBuf_It it	= lit.begin();
	_LitBuf_It it_e = lit.end();
	for(; it != it_e; ++it)
	{
	  if((*it)->id == id)
		break;
	}
	return it;
  }

  DWORD	  id;
  char	  descriptor[DR_MAX_NAME];
  char	  file[DR_MAX_FILE];
  _LitBuf lit;
};

struct lwItemLitFileHead
{
  DWORD version;
  DWORD type;
  DWORD mask[4];
};

class lwItemLit
{
  typedef vector<lwItemLitInfo*> _ItemBuf;
  typedef _ItemBuf::iterator	 _ItemBuf_It;

  private:
  _ItemBuf _item;

  private:
  _ItemBuf_It _FindItemWithId(DWORD id);

  public:
  lwItemLit();
  ~lwItemLit();

  DR_RESULT Clear();
  DR_RESULT Load(const char* file);
  DR_RESULT Save(const char* file);

  DR_RESULT GetItemNum(DWORD* num);
  DR_RESULT GetItemWithId(DWORD id, lwItemLitInfo** info);
  DR_RESULT FindItem(DWORD id, lwItemLitInfo** info);
  DR_RESULT AddItem(DWORD id, const char* desc, lwItemLitInfo** ret_info);
  DR_RESULT RemoveItem(DWORD item_id);
  DR_RESULT RemoveItemLit(DWORD item_id, DWORD lit_id);
};
