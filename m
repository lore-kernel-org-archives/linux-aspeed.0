From: kernel test robot <lkp@intel.com>
Date: Tue, 16 Nov 2021 09:01:52 +0800
Subject: [PATCH v5] Add payload to be 32-bit aligned to fix dropped packets
In-Reply-To: <20211115144846.GA12078@gmail.com>
References: <20211115144846.GA12078@gmail.com>
Message-ID: <202111160915.9clkkfsH-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Kumar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.16-rc1 next-20211115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Kumar-Thangavel/Add-payload-to-be-32-bit-aligned-to-fix-dropped-packets/20211115-224945
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 8ab774587903771821b59471cc723bba6d893942
config: riscv-randconfig-r026-20211115 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project fbe72e41b99dc7994daac300d208a955be3e4a0a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/dc2cde90f4de825ff92f0ad81bc70e132c6ad6ec
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kumar-Thangavel/Add-payload-to-be-32-bit-aligned-to-fix-dropped-packets/20211115-224945
        git checkout dc2cde90f4de825ff92f0ad81bc70e132c6ad6ec
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/ncsi/ncsi-cmd.c:298:9: warning: comparison of distinct pointer types ('typeof (payload) *' (aka 'int *') and 'typeof (padding_bytes) *' (aka 'const unsigned short *')) [-Wcompare-distinct-pointer-types]
           len += max(payload, padding_bytes);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   1 warning generated.


vim +298 net/ncsi/ncsi-cmd.c

   273	
   274	static struct ncsi_request *ncsi_alloc_command(struct ncsi_cmd_arg *nca)
   275	{
   276		struct ncsi_dev_priv *ndp = nca->ndp;
   277		struct ncsi_dev *nd = &ndp->ndev;
   278		struct net_device *dev = nd->dev;
   279		int hlen = LL_RESERVED_SPACE(dev);
   280		int tlen = dev->needed_tailroom;
   281		int payload;
   282		int len = hlen + tlen;
   283		struct sk_buff *skb;
   284		struct ncsi_request *nr;
   285	
   286		nr = ncsi_alloc_request(ndp, nca->req_flags);
   287		if (!nr)
   288			return NULL;
   289	
   290		/* NCSI command packet has 16-bytes header, payload, 4 bytes checksum.
   291		 * Payload needs padding so that the checksum field following payload is
   292		 * aligned to 32-bit boundary.
   293		 * The packet needs padding if its payload is less than 26 bytes to
   294		 * meet 64 bytes minimal ethernet frame length.
   295		 */
   296		len += sizeof(struct ncsi_cmd_pkt_hdr) + 4;
   297		payload = ALIGN(nca->payload, 4);
 > 298		len += max(payload, padding_bytes);
   299	
   300		/* Allocate skb */
   301		skb = alloc_skb(len, GFP_ATOMIC);
   302		if (!skb) {
   303			ncsi_free_request(nr);
   304			return NULL;
   305		}
   306	
   307		nr->cmd = skb;
   308		skb_reserve(skb, hlen);
   309		skb_reset_network_header(skb);
   310	
   311		skb->dev = dev;
   312		skb->protocol = htons(ETH_P_NCSI);
   313	
   314		return nr;
   315	}
   316	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 43898 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211116/a34a92d1/attachment-0001.gz>
