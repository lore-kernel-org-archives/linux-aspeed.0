From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 30 Nov 2021 09:30:48 +0000
Subject: [PATCH 1/3] usb: aspeed-vhub: add qualifier descriptor
In-Reply-To: <84b2d2c6b530d0a3a9b86b0ffcbfa70935bdb0a9.camel@kernel.crashing.org>
References: <20211126110954.2677627-1-neal_liu@aspeedtech.com>
 <20211126110954.2677627-2-neal_liu@aspeedtech.com>
 <84b2d2c6b530d0a3a9b86b0ffcbfa70935bdb0a9.camel@kernel.crashing.org>
Message-ID: <HK0PR06MB32028A343BDCF1C719918B8280679@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Sent: Tuesday, November 30, 2021 7:41 AM
> To: Neal Liu <neal_liu@aspeedtech.com>; Felipe Balbi <balbi@kernel.org>;
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Joel Stanley
> <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Cai Huoqing
> <caihuoqing@baidu.com>; Tao Ren <rentao.bupt@gmail.com>; Julia Lawall
> <julia.lawall@inria.fr>; kernel test robot <lkp@intel.com>; Sasha Levin
> <sashal@kernel.org>; linux-usb at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org
> Cc: BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH 1/3] usb: aspeed-vhub: add qualifier descriptor
> 
> On Fri, 2021-11-26 at 19:09 +0800, Neal Liu wrote:
> >
> > @@ -417,10 +435,9 @@ enum std_req_rc ast_vhub_std_hub_request(struct
> > ast_vhub_ep *ep,
> >
> >  		/* GET/SET_CONFIGURATION */
> >  	case DeviceRequest | USB_REQ_GET_CONFIGURATION:
> > -		return ast_vhub_simple_reply(ep, 1);
> > +		return ast_vhub_simple_reply(ep, vhub->current_config);
> >  	case DeviceOutRequest | USB_REQ_SET_CONFIGURATION:
> > -		if (wValue != 1)
> > -			return std_req_stall;
> > +		vhub->current_config = wValue;
> >  		return std_req_complete;
> 
> This is odd.. why should we support arbitrary SET_CONFIGURATION for configs
> we don't support ?
> 
> Otherwise looks good.
> 
> Cheers,
> Ben.
> 
This is unnecessary...
I'll remove it in next patch.
Thanks

-Neal

