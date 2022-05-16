From: kernel test robot <lkp@intel.com>
Date: Mon, 16 May 2022 18:21:57 +0800
Subject: [PATCH 1/3] usb: gadget: add Aspeed ast2600 udc driver
In-Reply-To: <20220513065728.857722-2-neal_liu@aspeedtech.com>
References: <20220513065728.857722-2-neal_liu@aspeedtech.com>
Message-ID: <202205161842.gsOJeWvM-lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Neal,

I love your patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on robh/for-next balbi-usb/testing/next v5.18-rc7 next-20220513]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Neal-Liu/add-Aspeed-udc-driver-for-ast2600/20220513-150314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: sparc-randconfig-s031-20220516 (https://download.01.org/0day-ci/archive/20220516/202205161842.gsOJeWvM-lkp at intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/272ae26f9fe89f60d584cf445431d0fa566eb24b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Neal-Liu/add-Aspeed-udc-driver-for-ast2600/20220513-150314
        git checkout 272ae26f9fe89f60d584cf445431d0fa566eb24b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash drivers/usb/gadget/udc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/usb/gadget/udc/aspeed_udc.c:1009:34: sparse: sparse: restricted __le16 degrades to integer
>> drivers/usb/gadget/udc/aspeed_udc.c:1037:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *src @@     got struct usb_ctrlrequest *creq @@
   drivers/usb/gadget/udc/aspeed_udc.c:1037:9: sparse:     expected void const volatile [noderef] __iomem *src
   drivers/usb/gadget/udc/aspeed_udc.c:1037:9: sparse:     got struct usb_ctrlrequest *creq
>> drivers/usb/gadget/udc/aspeed_udc.c:1066:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le16 [addressable] [usertype] wValue @@
   drivers/usb/gadget/udc/aspeed_udc.c:1066:25: sparse:     expected unsigned int [usertype] value
   drivers/usb/gadget/udc/aspeed_udc.c:1066:25: sparse:     got restricted __le16 [addressable] [usertype] wValue
   drivers/usb/gadget/udc/aspeed_udc.c:1070:37: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/aspeed_udc.c:1075:37: sparse: sparse: restricted __le16 degrades to integer
>> drivers/usb/gadget/udc/aspeed_udc.c:1518:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct usb_ctrlrequest *creq @@     got void [noderef] __iomem * @@
   drivers/usb/gadget/udc/aspeed_udc.c:1518:19: sparse:     expected struct usb_ctrlrequest *creq
   drivers/usb/gadget/udc/aspeed_udc.c:1518:19: sparse:     got void [noderef] __iomem *
>> drivers/usb/gadget/udc/aspeed_udc.c:619:38: sparse: sparse: cast truncates bits from constant value (80 becomes 0)
   drivers/usb/gadget/udc/aspeed_udc.c:625:12: sparse: sparse: context imbalance in 'ast_udc_ep_queue' - different lock contexts for basic block

vim +1009 drivers/usb/gadget/udc/aspeed_udc.c

   994	
   995	static void ast_udc_getstatus(struct ast_udc_dev *udc)
   996	{
   997		struct ast_udc_ep *ep;
   998		u16 status = 0;
   999		int epnum;
  1000	
  1001		switch (udc->creq->bRequestType & USB_RECIP_MASK) {
  1002		case USB_RECIP_DEVICE:
  1003			/* Get device status */
  1004			status = 1 << USB_DEVICE_SELF_POWERED;
  1005			break;
  1006		case USB_RECIP_INTERFACE:
  1007			break;
  1008		case USB_RECIP_ENDPOINT:
> 1009			epnum = udc->creq->wIndex & USB_ENDPOINT_NUMBER_MASK;
  1010			status = udc->ep[epnum].stopped;
  1011			break;
  1012		default:
  1013			goto stall;
  1014		}
  1015	
  1016		ep = &udc->ep[epnum];
  1017		EP_DBG(ep, "status: 0x%x\n", status);
  1018		ast_udc_ep0_data_tx(udc, (u8 *)&status, sizeof(status));
  1019	
  1020		return;
  1021	
  1022	stall:
  1023		EP_DBG(ep, "Can't respond request\n");
  1024		ast_udc_write(udc, ast_udc_read(udc, AST_UDC_EP0_CTRL) | EP0_STALL,
  1025			      AST_UDC_EP0_CTRL);
  1026	}
  1027	
  1028	static void ast_udc_ep0_handle_setup(struct ast_udc_dev *udc)
  1029	{
  1030		struct ast_udc_ep *ep = &udc->ep[0];
  1031		struct ast_udc_request *req;
  1032		struct usb_ctrlrequest crq;
  1033		int req_num = 0;
  1034		u16 ep_num = 0;
  1035		int rc;
  1036	
> 1037		memcpy_fromio(&crq, udc->creq, sizeof(crq));
  1038	
  1039		SETUP_DBG(udc, "SETEUP packet: %02x/%02x/%04x/%04x/%04x\n",
  1040			  crq.bRequestType, crq.bRequest, le16_to_cpu(crq.wValue),
  1041			  le16_to_cpu(crq.wIndex), le16_to_cpu(crq.wLength));
  1042	
  1043		/*
  1044		 * Cleanup ep0 request(s) in queue because
  1045		 * there is a new control setup comes.
  1046		 */
  1047		list_for_each_entry(req, &udc->ep[0].queue, queue) {
  1048			req_num++;
  1049			EP_DBG(ep, "there is req %p in ep0 queue !\n", req);
  1050		}
  1051	
  1052		if (req_num)
  1053			ast_udc_nuke(&udc->ep[0], -ETIMEDOUT);
  1054	
  1055		udc->ep[0].dir_in = crq.bRequestType & USB_DIR_IN;
  1056	
  1057		if ((crq.bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD) {
  1058			switch (crq.bRequest) {
  1059			case USB_REQ_SET_ADDRESS:
  1060				if (ast_udc_read(udc, AST_UDC_STS) & UDC_STS_HIGHSPEED)
  1061					udc->gadget.speed = USB_SPEED_HIGH;
  1062				else
  1063					udc->gadget.speed = USB_SPEED_FULL;
  1064	
  1065				SETUP_DBG(udc, "set addr: 0x%x\n", crq.wValue);
> 1066				ast_udc_write(udc, crq.wValue, AST_UDC_CONFIG);
  1067				goto req_complete;
  1068	
  1069			case USB_REQ_CLEAR_FEATURE:
  1070				ep_num = crq.wIndex & USB_ENDPOINT_NUMBER_MASK;
  1071				SETUP_DBG(udc, "ep%d: CLEAR FEATURE\n", ep_num);
  1072				goto req_driver;
  1073	
  1074			case USB_REQ_SET_FEATURE:
  1075				ep_num = crq.wIndex & USB_ENDPOINT_NUMBER_MASK;
  1076				SETUP_DBG(udc, "ep%d: SET FEATURE\n", ep_num);
  1077				goto req_driver;
  1078	
  1079			case USB_REQ_GET_STATUS:
  1080				ast_udc_getstatus(udc);
  1081				return;
  1082	
  1083			default:
  1084				goto req_driver;
  1085			}
  1086	
  1087		}
  1088	
  1089	req_driver:
  1090		if (udc->driver) {
  1091			SETUP_DBG(udc, "Forwarding %s to gadget...\n",
  1092				  udc->gadget.name);
  1093	
  1094			spin_unlock(&udc->lock);
  1095			rc = udc->driver->setup(&udc->gadget, &crq);
  1096			spin_lock(&udc->lock);
  1097	
  1098		} else
  1099			SETUP_DBG(udc, "No gadget for request !\n");
  1100	
  1101		if (rc >= 0)
  1102			return;
  1103	
  1104		/* Stall if gadget failed */
  1105		SETUP_DBG(udc, "Stalling, rc:0x%x\n", rc);
  1106		ast_udc_write(udc, ast_udc_read(udc, AST_UDC_EP0_CTRL) | EP0_STALL,
  1107			      AST_UDC_EP0_CTRL);
  1108		return;
  1109	
  1110	req_complete:
  1111		SETUP_DBG(udc, "ep%d: Sending IN status without data\n", ep_num);
  1112		ast_udc_write(udc, EP0_TX_BUFF_RDY, AST_UDC_EP0_CTRL);
  1113	}
  1114	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
