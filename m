From: kernel test robot <lkp@intel.com>
Date: Thu, 30 Jun 2022 01:56:15 +0800
Subject: [PATCH -next] usb: gadget: dereference before null check
In-Reply-To: <20220629080726.107297-1-mailmesebin00@gmail.com>
References: <20220629080726.107297-1-mailmesebin00@gmail.com>
Message-ID: <202206300156.qNpjgo9z-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi SebinSebastian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220628]

url:    https://github.com/intel-lab-lkp/linux/commits/SebinSebastian/usb-gadget-dereference-before-null-check/20220629-161008
base:    cb71b93c2dc36d18a8b05245973328d018272cdf
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220630/202206300156.qNpjgo9z-lkp at intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/97ebbd93f269a58b3b5a003898d6e09c29a73ab0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review SebinSebastian/usb-gadget-dereference-before-null-check/20220629-161008
        git checkout 97ebbd93f269a58b3b5a003898d6e09c29a73ab0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/usb/gadget/udc/aspeed_udc.c: In function 'ast_udc_ep_enable':
>> drivers/usb/gadget/udc/aspeed_udc.c:349:22: error: 'ep' undeclared (first use in this function); did you mean '_ep'?
     349 |         if (!_ep || !ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT ||
         |                      ^~
         |                      _ep
   drivers/usb/gadget/udc/aspeed_udc.c:349:22: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/usb/gadget/udc/aspeed_udc.c:350:13: error: 'maxpacket' undeclared (first use in this function)
     350 |             maxpacket == 0 || maxpacket > ep->ep.maxpacket) {
         |             ^~~~~~~~~
   drivers/usb/gadget/udc/aspeed_udc.c:355:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     355 |         u16 maxpacket = usb_endpoint_maxp(desc);
         |         ^~~


vim +349 drivers/usb/gadget/udc/aspeed_udc.c

055276c1320564b Neal Liu       2022-05-23  340  
055276c1320564b Neal Liu       2022-05-23  341  static int ast_udc_ep_enable(struct usb_ep *_ep,
055276c1320564b Neal Liu       2022-05-23  342  			     const struct usb_endpoint_descriptor *desc)
055276c1320564b Neal Liu       2022-05-23  343  {
055276c1320564b Neal Liu       2022-05-23  344  	unsigned long flags;
055276c1320564b Neal Liu       2022-05-23  345  	u32 ep_conf = 0;
055276c1320564b Neal Liu       2022-05-23  346  	u8 dir_in;
055276c1320564b Neal Liu       2022-05-23  347  	u8 type;
055276c1320564b Neal Liu       2022-05-23  348  
055276c1320564b Neal Liu       2022-05-23 @349  	if (!_ep || !ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT ||
055276c1320564b Neal Liu       2022-05-23 @350  	    maxpacket == 0 || maxpacket > ep->ep.maxpacket) {
055276c1320564b Neal Liu       2022-05-23  351  		EP_DBG(ep, "Failed, invalid EP enable param\n");
055276c1320564b Neal Liu       2022-05-23  352  		return -EINVAL;
055276c1320564b Neal Liu       2022-05-23  353  	}
055276c1320564b Neal Liu       2022-05-23  354  
97ebbd93f269a58 SebinSebastian 2022-06-29  355  	u16 maxpacket = usb_endpoint_maxp(desc);
97ebbd93f269a58 SebinSebastian 2022-06-29  356  	struct ast_udc_ep *ep = to_ast_ep(_ep);
97ebbd93f269a58 SebinSebastian 2022-06-29  357  	struct ast_udc_dev *udc = ep->udc;
97ebbd93f269a58 SebinSebastian 2022-06-29  358  	u8 epnum = usb_endpoint_num(desc);
97ebbd93f269a58 SebinSebastian 2022-06-29  359  
055276c1320564b Neal Liu       2022-05-23  360  	if (!udc->driver) {
055276c1320564b Neal Liu       2022-05-23  361  		EP_DBG(ep, "bogus device state\n");
055276c1320564b Neal Liu       2022-05-23  362  		return -ESHUTDOWN;
055276c1320564b Neal Liu       2022-05-23  363  	}
055276c1320564b Neal Liu       2022-05-23  364  
055276c1320564b Neal Liu       2022-05-23  365  	EP_DBG(ep, "maxpacket:0x%x\n", maxpacket);
055276c1320564b Neal Liu       2022-05-23  366  
055276c1320564b Neal Liu       2022-05-23  367  	spin_lock_irqsave(&udc->lock, flags);
055276c1320564b Neal Liu       2022-05-23  368  
055276c1320564b Neal Liu       2022-05-23  369  	ep->desc = desc;
055276c1320564b Neal Liu       2022-05-23  370  	ep->stopped = 0;
055276c1320564b Neal Liu       2022-05-23  371  	ep->ep.maxpacket = maxpacket;
055276c1320564b Neal Liu       2022-05-23  372  	ep->chunk_max = AST_EP_DMA_DESC_MAX_LEN;
055276c1320564b Neal Liu       2022-05-23  373  
055276c1320564b Neal Liu       2022-05-23  374  	if (maxpacket < AST_UDC_EPn_MAX_PACKET)
055276c1320564b Neal Liu       2022-05-23  375  		ep_conf = EP_SET_MAX_PKT(maxpacket);
055276c1320564b Neal Liu       2022-05-23  376  
055276c1320564b Neal Liu       2022-05-23  377  	ep_conf |= EP_SET_EP_NUM(epnum);
055276c1320564b Neal Liu       2022-05-23  378  
055276c1320564b Neal Liu       2022-05-23  379  	type = usb_endpoint_type(desc);
055276c1320564b Neal Liu       2022-05-23  380  	dir_in = usb_endpoint_dir_in(desc);
055276c1320564b Neal Liu       2022-05-23  381  	ep->dir_in = dir_in;
055276c1320564b Neal Liu       2022-05-23  382  	if (!ep->dir_in)
055276c1320564b Neal Liu       2022-05-23  383  		ep_conf |= EP_DIR_OUT;
055276c1320564b Neal Liu       2022-05-23  384  
055276c1320564b Neal Liu       2022-05-23  385  	EP_DBG(ep, "type %d, dir_in %d\n", type, dir_in);
055276c1320564b Neal Liu       2022-05-23  386  	switch (type) {
055276c1320564b Neal Liu       2022-05-23  387  	case USB_ENDPOINT_XFER_ISOC:
055276c1320564b Neal Liu       2022-05-23  388  		ep_conf |= EP_SET_TYPE_MASK(EP_TYPE_ISO);
055276c1320564b Neal Liu       2022-05-23  389  		break;
055276c1320564b Neal Liu       2022-05-23  390  
055276c1320564b Neal Liu       2022-05-23  391  	case USB_ENDPOINT_XFER_BULK:
055276c1320564b Neal Liu       2022-05-23  392  		ep_conf |= EP_SET_TYPE_MASK(EP_TYPE_BULK);
055276c1320564b Neal Liu       2022-05-23  393  		break;
055276c1320564b Neal Liu       2022-05-23  394  
055276c1320564b Neal Liu       2022-05-23  395  	case USB_ENDPOINT_XFER_INT:
055276c1320564b Neal Liu       2022-05-23  396  		ep_conf |= EP_SET_TYPE_MASK(EP_TYPE_INT);
055276c1320564b Neal Liu       2022-05-23  397  		break;
055276c1320564b Neal Liu       2022-05-23  398  	}
055276c1320564b Neal Liu       2022-05-23  399  
055276c1320564b Neal Liu       2022-05-23  400  	ep->desc_mode = udc->desc_mode && ep->descs_dma && ep->dir_in;
055276c1320564b Neal Liu       2022-05-23  401  	if (ep->desc_mode) {
055276c1320564b Neal Liu       2022-05-23  402  		ast_ep_write(ep, EP_DMA_CTRL_RESET, AST_UDC_EP_DMA_CTRL);
055276c1320564b Neal Liu       2022-05-23  403  		ast_ep_write(ep, 0, AST_UDC_EP_DMA_STS);
055276c1320564b Neal Liu       2022-05-23  404  		ast_ep_write(ep, ep->descs_dma, AST_UDC_EP_DMA_BUFF);
055276c1320564b Neal Liu       2022-05-23  405  
055276c1320564b Neal Liu       2022-05-23  406  		/* Enable Long Descriptor Mode */
055276c1320564b Neal Liu       2022-05-23  407  		ast_ep_write(ep, EP_DMA_CTRL_IN_LONG_MODE | EP_DMA_DESC_MODE,
055276c1320564b Neal Liu       2022-05-23  408  			     AST_UDC_EP_DMA_CTRL);
055276c1320564b Neal Liu       2022-05-23  409  
055276c1320564b Neal Liu       2022-05-23  410  		ep->descs_wptr = 0;
055276c1320564b Neal Liu       2022-05-23  411  
055276c1320564b Neal Liu       2022-05-23  412  	} else {
055276c1320564b Neal Liu       2022-05-23  413  		ast_ep_write(ep, EP_DMA_CTRL_RESET, AST_UDC_EP_DMA_CTRL);
055276c1320564b Neal Liu       2022-05-23  414  		ast_ep_write(ep, EP_DMA_SINGLE_STAGE, AST_UDC_EP_DMA_CTRL);
055276c1320564b Neal Liu       2022-05-23  415  		ast_ep_write(ep, 0, AST_UDC_EP_DMA_STS);
055276c1320564b Neal Liu       2022-05-23  416  	}
055276c1320564b Neal Liu       2022-05-23  417  
055276c1320564b Neal Liu       2022-05-23  418  	/* Cleanup data toggle just in case */
055276c1320564b Neal Liu       2022-05-23  419  	ast_udc_write(udc, EP_TOGGLE_SET_EPNUM(epnum), AST_VHUB_EP_DATA);
055276c1320564b Neal Liu       2022-05-23  420  
055276c1320564b Neal Liu       2022-05-23  421  	/* Enable EP */
055276c1320564b Neal Liu       2022-05-23  422  	ast_ep_write(ep, ep_conf | EP_ENABLE, AST_UDC_EP_CONFIG);
055276c1320564b Neal Liu       2022-05-23  423  
055276c1320564b Neal Liu       2022-05-23  424  	EP_DBG(ep, "ep_config: 0x%x\n", ast_ep_read(ep, AST_UDC_EP_CONFIG));
055276c1320564b Neal Liu       2022-05-23  425  
055276c1320564b Neal Liu       2022-05-23  426  	spin_unlock_irqrestore(&udc->lock, flags);
055276c1320564b Neal Liu       2022-05-23  427  
055276c1320564b Neal Liu       2022-05-23  428  	return 0;
055276c1320564b Neal Liu       2022-05-23  429  }
055276c1320564b Neal Liu       2022-05-23  430  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
