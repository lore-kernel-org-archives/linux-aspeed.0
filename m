From: kernel test robot <lkp@intel.com>
Date: Fri, 12 Nov 2021 11:32:26 +0800
Subject: [PATCH v4] Add payload to be 32-bit aligned to fix dropped packets
In-Reply-To: <20211110095432.GA9571@gmail.com>
References: <20211110095432.GA9571@gmail.com>
Message-ID: <202111121141.QXPSnerK-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Kumar,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.15 next-20211111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Kumar-Thangavel/Add-payload-to-be-32-bit-aligned-to-fix-dropped-packets/20211110-175537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git cb690f5238d71f543f4ce874aa59237cf53a877c
config: hexagon-buildonly-randconfig-r006-20211112 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 63ef0e17e28827eae53133b3467bdac7d9729318)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/263eaf647698f405f4f9905c947bf73b87c55b79
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kumar-Thangavel/Add-payload-to-be-32-bit-aligned-to-fix-dropped-packets/20211110-175537
        git checkout 263eaf647698f405f4f9905c947bf73b87c55b79
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=hexagon 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/ncsi/ncsi-cmd.c:225:9: error: comparison of distinct pointer types ('typeof (payload) *' (aka 'unsigned short *') and 'typeof (26) *' (aka 'int *')) [-Werror,-Wcompare-distinct-pointer-types]
           len += max(payload, 26);
                  ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 error generated.


vim +225 net/ncsi/ncsi-cmd.c

   210	
   211	static int ncsi_cmd_handler_oem(struct sk_buff *skb,
   212					struct ncsi_cmd_arg *nca)
   213	{
   214		struct ncsi_cmd_oem_pkt *cmd;
   215		unsigned int len;
   216		/* NC-SI spec DSP_0222_1.2.0, section 8.2.2.2
   217		 * requires payload to be padded with 0 to
   218		 * 32-bit boundary before the checksum field.
   219		 * Ensure the padding bytes are accounted for in
   220		 * skb allocation
   221		 */
   222	
   223		unsigned short payload = ALIGN(nca->payload, 4);
   224		len = sizeof(struct ncsi_cmd_pkt_hdr) + 4;
 > 225		len += max(payload, 26);
   226	
   227		cmd = skb_put_zero(skb, len);
   228		memcpy(&cmd->mfr_id, nca->data, nca->payload);
   229		ncsi_cmd_build_header(&cmd->cmd.common, nca);
   230	
   231		return 0;
   232	}
   233	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33648 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211112/737cb78d/attachment-0001.gz>
