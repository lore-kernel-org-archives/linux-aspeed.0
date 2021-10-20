From: kernel test robot <lkp@intel.com>
Date: Wed, 20 Oct 2021 08:27:05 +0800
Subject: [PATCH v2] Add payload to be 32-bit aligned to fix dropped packets
In-Reply-To: <20211019144127.GA12978@gmail.com>
References: <20211019144127.GA12978@gmail.com>
Message-ID: <202110200839.EJJlwzor-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Kumar,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.15-rc6 next-20211019]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Kumar-Thangavel/Add-payload-to-be-32-bit-aligned-to-fix-dropped-packets/20211019-225018
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 519d81956ee277b4419c723adfb154603c2565ba
config: i386-randconfig-a005-20211019 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b37efed957ed0a0193d80020aefd55cb587dfc1f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/177d89a1966a0830ac30b8962ac9af76c1d675ae
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kumar-Thangavel/Add-payload-to-be-32-bit-aligned-to-fix-dropped-packets/20211019-225018
        git checkout 177d89a1966a0830ac30b8962ac9af76c1d675ae
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/ncsi/ncsi-cmd.c:298:34: error: expected ';' after expression
           payload = ALIGN(nca->payload, 4)
                                           ^
                                           ;
   1 error generated.


vim +298 net/ncsi/ncsi-cmd.c

   274	
   275	static struct ncsi_request *ncsi_alloc_command(struct ncsi_cmd_arg *nca)
   276	{
   277		struct ncsi_dev_priv *ndp = nca->ndp;
   278		struct ncsi_dev *nd = &ndp->ndev;
   279		struct net_device *dev = nd->dev;
   280		int hlen = LL_RESERVED_SPACE(dev);
   281		int tlen = dev->needed_tailroom;
   282		int payload;
   283		int len = hlen + tlen;
   284		struct sk_buff *skb;
   285		struct ncsi_request *nr;
   286	
   287		nr = ncsi_alloc_request(ndp, nca->req_flags);
   288		if (!nr)
   289			return NULL;
   290	
   291		/* NCSI command packet has 16-bytes header, payload, 4 bytes checksum.
   292		 * Payload needs padding so that the checksum field following payload is
   293		 * aligned to 32-bit boundary.
   294		 * The packet needs padding if its payload is less than 26 bytes to
   295		 * meet 64 bytes minimal ethernet frame length.
   296		 */
   297		len += sizeof(struct ncsi_cmd_pkt_hdr) + 4;
 > 298		payload = ALIGN(nca->payload, 4)
   299		if (payload < 26)
   300			len += 26;
   301		else
   302			len += payload;
   303	
   304		/* Allocate skb */
   305		skb = alloc_skb(len, GFP_ATOMIC);
   306		if (!skb) {
   307			ncsi_free_request(nr);
   308			return NULL;
   309		}
   310	
   311		nr->cmd = skb;
   312		skb_reserve(skb, hlen);
   313		skb_reset_network_header(skb);
   314	
   315		skb->dev = dev;
   316		skb->protocol = htons(ETH_P_NCSI);
   317	
   318		return nr;
   319	}
   320	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34495 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211020/7ef21e4c/attachment-0001.gz>
