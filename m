From: kernel test robot <lkp@intel.com>
Date: Fri, 13 May 2022 19:03:22 +0800
Subject: [PATCH 1/3] usb: gadget: add Aspeed ast2600 udc driver
In-Reply-To: <20220513065728.857722-2-neal_liu@aspeedtech.com>
References: <20220513065728.857722-2-neal_liu@aspeedtech.com>
Message-ID: <202205131836.QEUySDoN-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Neal,

I love your patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on robh/for-next v5.18-rc6 next-20220513]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Neal-Liu/add-Aspeed-udc-driver-for-ast2600/20220513-150314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220513/202205131836.QEUySDoN-lkp at intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/272ae26f9fe89f60d584cf445431d0fa566eb24b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Neal-Liu/add-Aspeed-udc-driver-for-ast2600/20220513-150314
        git checkout 272ae26f9fe89f60d584cf445431d0fa566eb24b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/usb/gadget/udc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/gadget/udc/aspeed_udc.c: In function 'ast_udc_ep0_out':
>> drivers/usb/gadget/udc/aspeed_udc.c:790:13: warning: variable 'buf' set but not used [-Wunused-but-set-variable]
     790 |         u8 *buf;
         |             ^~~
   drivers/usb/gadget/udc/aspeed_udc.c: In function 'ast_udc_ep0_handle_setup':
>> drivers/usb/gadget/udc/aspeed_udc.c:1099:60: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
    1099 |                 SETUP_DBG(udc, "No gadget for request !\n");
         |                                                            ^
>> drivers/usb/gadget/udc/aspeed_udc.c:1034:13: warning: variable 'ep_num' set but not used [-Wunused-but-set-variable]
    1034 |         u16 ep_num = 0;
         |             ^~~~~~


vim +/buf +790 drivers/usb/gadget/udc/aspeed_udc.c

   783	
   784	static void ast_udc_ep0_out(struct ast_udc_dev *udc)
   785	{
   786		struct device *dev = &udc->pdev->dev;
   787		struct ast_udc_ep *ep = &udc->ep[0];
   788		struct ast_udc_request *req;
   789		u16 rx_len;
 > 790		u8 *buf;
   791	
   792		if (list_empty(&ep->queue))
   793			return;
   794	
   795		req = list_entry(ep->queue.next, struct ast_udc_request, queue);
   796	
   797		buf = req->req.buf;
   798		rx_len = EP0_GET_RX_LEN(ast_udc_read(udc, AST_UDC_EP0_CTRL));
   799		req->req.actual += rx_len;
   800	
   801		SETUP_DBG(udc, "req %p (%d/%d)\n", req,
   802			  req->req.actual, req->req.length);
   803	
   804		if ((rx_len < ep->ep.maxpacket) ||
   805		    (req->req.actual == req->req.length)) {
   806			ast_udc_ep0_tx(udc);
   807			if (!ep->dir_in)
   808				ast_udc_done(ep, req, 0);
   809	
   810		} else {
   811			if (rx_len > req->req.length) {
   812				// Issue Fix
   813				dev_warn(dev, "Something wrong (%d/%d)\n",
   814					 req->req.actual, req->req.length);
   815				ast_udc_ep0_tx(udc);
   816				ast_udc_done(ep, req, 0);
   817				return;
   818			}
   819	
   820			ep->dir_in = 0;
   821	
   822			/* More works */
   823			ast_udc_ep0_queue(ep, req);
   824		}
   825	}
   826	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
