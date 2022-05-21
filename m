From: kernel test robot <lkp@intel.com>
Date: Sat, 21 May 2022 09:57:42 +0800
Subject: [PATCH v4 1/3] usb: gadget: add Aspeed ast2600 udc driver
In-Reply-To: <20220520090617.2225080-2-neal_liu@aspeedtech.com>
References: <20220520090617.2225080-2-neal_liu@aspeedtech.com>
Message-ID: <202205210945.hUK3CONa-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Neal,

I love your patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on robh/for-next v5.18-rc7 next-20220520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Neal-Liu/add-Aspeed-udc-driver-for-ast2600/20220520-170904
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220521/202205210945.hUK3CONa-lkp at intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/19f3e863ea1b55f570db57febb96c6e8cb39c145
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Neal-Liu/add-Aspeed-udc-driver-for-ast2600/20220520-170904
        git checkout 19f3e863ea1b55f570db57febb96c6e8cb39c145
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/clk/ drivers/usb/gadget/udc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/gadget/udc/aspeed_udc.c:310:11: warning: comparison of address of 'ep->queue' equal to a null pointer is always false [-Wtautological-pointer-compare]
           if (&ep->queue == NULL)
                ~~~~^~~~~    ~~~~
>> drivers/usb/gadget/udc/aspeed_udc.c:967:7: warning: variable 'len' is uninitialized when used here [-Wuninitialized]
                   if (len < ep->ep.maxpacket) {
                       ^~~
   drivers/usb/gadget/udc/aspeed_udc.c:908:9: note: initialize the variable 'len' to silence this warning
           u16 len;
                  ^
                   = 0
>> drivers/usb/gadget/udc/aspeed_udc.c:1011:7: warning: variable 'epnum' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case USB_RECIP_INTERFACE:
                ^~~~~~~~~~~~~~~~~~~
   include/uapi/linux/usb/ch9.h:67:30: note: expanded from macro 'USB_RECIP_INTERFACE'
   #define USB_RECIP_INTERFACE             0x01
                                           ^~~~
   drivers/usb/gadget/udc/aspeed_udc.c:1021:16: note: uninitialized use occurs here
           ep = &udc->ep[epnum];
                         ^~~~~
   drivers/usb/gadget/udc/aspeed_udc.c:1007:7: warning: variable 'epnum' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
           case USB_RECIP_DEVICE:
                ^~~~~~~~~~~~~~~~
   include/uapi/linux/usb/ch9.h:66:27: note: expanded from macro 'USB_RECIP_DEVICE'
   #define USB_RECIP_DEVICE                0x00
                                           ^~~~
   drivers/usb/gadget/udc/aspeed_udc.c:1021:16: note: uninitialized use occurs here
           ep = &udc->ep[epnum];
                         ^~~~~
   drivers/usb/gadget/udc/aspeed_udc.c:1002:11: note: initialize the variable 'epnum' to silence this warning
           u16 epnum;
                    ^
                     = 0
>> drivers/usb/gadget/udc/aspeed_udc.c:1096:6: warning: variable 'rc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (udc->driver) {
               ^~~~~~~~~~~
   drivers/usb/gadget/udc/aspeed_udc.c:1108:6: note: uninitialized use occurs here
           if (rc >= 0)
               ^~
   drivers/usb/gadget/udc/aspeed_udc.c:1096:2: note: remove the 'if' if its condition is always true
           if (udc->driver) {
           ^~~~~~~~~~~~~~~~~
   drivers/usb/gadget/udc/aspeed_udc.c:1039:8: note: initialize the variable 'rc' to silence this warning
           int rc;
                 ^
                  = 0
   5 warnings generated.


vim +310 drivers/usb/gadget/udc/aspeed_udc.c

   304	
   305	static void ast_udc_nuke(struct ast_udc_ep *ep, int status)
   306	{
   307		int count = 0;
   308	
   309		/* Sanity check */
 > 310		if (&ep->queue == NULL)
   311			return;
   312	
   313		while (!list_empty(&ep->queue)) {
   314			struct ast_udc_request *req;
   315	
   316			req = list_entry(ep->queue.next, struct ast_udc_request,
   317					 queue);
   318			ast_udc_done(ep, req, status);
   319			count++;
   320		}
   321	
   322		if (count)
   323			EP_DBG(ep, "Nuked %d request(s)\n", count);
   324	}
   325	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
