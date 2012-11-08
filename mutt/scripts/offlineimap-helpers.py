# got some of this from https://github.com/pbrisbin/mutt-config/blob/master/nametrans.py

import re
from subprocess import Popen, PIPE

mapping = { 'INBOX':              'INBOX'
          , '[Gmail]/All Mail':   'all_mail'
          , '[Gmail]/Drafts':     'drafts'
          , '[Gmail]/Important':  'important'
          , '[Gmail]/Sent Mail':  'sent_mail'
          , '[Gmail]/Spam':       'spam'
          , '[Gmail]/Starred':    'starred'
          , '[Gmail]/Trash':      'trash'
          }

r_mapping = { val: key for key, val in mapping.items() }

def nt_remote(folder):
    try:
        return mapping[folder]
    except:
        return re.sub(' ', '_', folder)

def nt_local(folder):
    try:
        return r_mapping[folder]
    except:
        return re.sub('_', ' ', folder)

# folderfilter = exclude(['Label', 'Label', ... ])
def exclude(excludes):
    def inner(folder):
        try:
            excludes.index(folder)
            return False
        except:
            return True

    return inner

def get_password(server):
  try:
    return Popen("~/.mutt/scripts/keychain-password "+server, shell=True, stdout=PIPE).communicate()[0]
  except:
    return ''
