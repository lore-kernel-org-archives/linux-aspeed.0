Return-Path: <linux-aspeed+bounces-5182-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6C3CC6B03
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 Oct 2026 07:34:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3mLg4Kmgz30Vn;
	Tue, 13 Oct 2026 18:34:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791876875;
	cv=none; b=YBEXghZpPP1zIFd7FICmEegscdtGHy6M83MBnRFdOU9vAfVPXTAHQHvimasyZQj8seW8x+j/6wYaFsRsmPYarc8uCN4I2xxOm6a49OX7Hw8FzUMYta21DvxOymYlER0s5FTwoKsn17c+XH1Vwaxq+IiIH7yKMUWkof0CIWU/sT4BDrK8ZB6M/QTZOPc99I3gUNPH/u6Rj6uZzE/Dr0nCtDa6oyq9TbAdBfD6oRbXxWte+huqU/A4C2oje28YNS+qZ7QXLHVdOT34oPJWqVDARgdJOvDq8BMKGSp8YCXvwFi8Peffac/eSJl5kif+PDcDpM0XWS+zgkypPbP85QhZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791876875; c=relaxed/relaxed;
	bh=TGN8I51EsiCeoMuqdEJrefdQGvxBjSECOZmfLFe8Da8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrjET/iBX7KcFJBkG/Pn5oTvCsfC95bnWNw8U5eAwPNNIWOwPw4VVNpecRBTpdHFzmkBCTFz8edhv8ZaZIcV8eDu/20T/IjLi+bWYFSoLig9ytTkrXYZGwNq3i8SaVmOTYX5J+Vu705zvIPokknH5fV/1EIFnNK+ggZEKkHrl7Nbd0q0pDLHGAgG6D59fEXkZLdQIEoRGrmr4f9rpuqppDyISMF5sgOsNlwoo8GTVEorGDMWSUi1wIAKuLFGfV98xJYvee//cJzRJxHigEHkh2O9OcnHHxDCeY58kc2+gDmuNDEbXL5VaCyQyhNfhuF5R4IL4d6W+zCbLt1cQ1snTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P7R2TGgb; dkim-atps=neutral; spf=pass (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P7R2TGgb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Tue, 13 Oct 2026 18:34:31 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3mLb5VYQz30VM
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Oct 2026 18:34:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791876872; x=1823412872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NzspRS2hDrJsjAe8AK0YYi1dL16p14T9VINuEY50WDA=;
  b=P7R2TGgbYHHoVV/UBfgFzQGG0bzPJ9jwoNq+InaJboEb3lp1rAxFOYEm
   Gh5tfy4fFQwUUyGvy67JM5iKznlEx1w3fYYRqDgqvehWee/FOuJEQScar
   LUCST/2P/FPM+nVzcvKXOzLxm0Q3y0qU/gyLGTDJoEklXFJtkdEARV9Qe
   9miqL4ab0/7QwrncYYoB8Aj8x17wS8XNGkU0EA0GWgQHS2DcuCEAzt7o6
   QZD36J9fiZHjPUBX0GVZM83oSdVaSPZb4KxH1IrHo8xxYTQVWYbI81gcV
   F7Ks07RxqVpy+Lt+1oQB+3ssz3wwM5MJSbjl2pSVxTvOTWEVW3Udm4Hzw
   Q==;
X-CSE-ConnectionGUID: lMmF56/cRf2InbAsIyO1OQ==
X-CSE-MsgGUID: NnzMF6bFQuWgVQJMlqPygg==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="466070"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="466070"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 00:33:21 -0700
X-CSE-ConnectionGUID: xXh+qmemSsK620RE9vOEtA==
X-CSE-MsgGUID: vIyL18cTQ/SYvrImMz4a5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1193790"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 00:33:13 -0700
Date: Tue, 13 Oct 2026 10:33:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-parisc@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 6/6] serial: 8250: make port operations work on struct
 uart_8250_port
Message-ID: <as3etnbZatn4sbfx@ashevche-desk.local>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 08:48:51AM +0200, Jiri Slaby (SUSE) wrote:
> serial8250_register_8250_port() returns a line number and the other
> port operations (serial8250_unregister_port(), serial8250_suspend_port(),
> serial8250_resume_port()) accept it. Many drivers then convert the line
> back to the port using serial8250_get_port() anyway.
> 
> Switch the interface to struct uart_8250_port:
> * serial8250_register_8250_port() now returns the registered port, or
> an ERR_PTR() on failure.
> * serial8250_unregister_port(), serial8250_suspend_port() and
> serial8250_resume_port() accept the port.
> 
> Convert all users accordingly. Drivers store the port pointer instead
> of the line number. Several drivers kept a private struct only to hold
> the line (airoha, dfl, em, fsl, ioc3); these are dropped and the port
> is stored as drvdata directly.
> 
> This also fixes two latent issues:
> * For a CIR port, serial8250_register_8250_port() used to return 0.
> Callers stored this as the line, so a later unregister/suspend/resume
> operated on ttyS0. Now the CIR port itself is returned.
> * 8250_acorn checked ports[i] > 0 on removal, so a port registered as
> line 0 was never unregistered.
> 
> There are no more users of serial8250_get_port() outside of the 8250
> core, so drop its EXPORT.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>

Why not having Ilpo's Cc in the below list?

> Assisted-by: LLM
> ---
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Billy Tsai <billy_tsai@aspeedtech.com>
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
> Cc: Ray Jui <ray.jui@broadcom.com>
> Cc: Scott Branden <scott.branden@broadcom.com>
> Cc: Al Cooper <alcooperx@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> Cc: Thierry Reding <thierry.reding@kernel.org>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-aspeed@lists.ozlabs.org
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org

> [v2] include err.h (Ilpo)
> ---

...

>  	seq_printf(s, "%7s: /dev/ptp%d\n", "PTP", ptp_clock_index(bp->ptp));
>  	for (i = 0; i < __PORT_COUNT; i++) {

What about

		struct uart_8250_port *uport = bp->port[i].uport;

here and use it accordingly in the below code?

> -		if (bp->port[i].line != -1)
> +		if (bp->port[i].uport)
>  			seq_printf(s, "%7s: /dev/ttyS%d\n", ptp_ocp_tty_port_name(i),
> -				   bp->port[i].line);
> +				   bp->port[i].uport->port.line);
>  	}

...

>  	for (i = 0; i < __PORT_COUNT; i++)
> -		if (bp->port[i].line != -1)
> -			serial8250_unregister_port(bp->port[i].line);
> +		if (bp->port[i].uport)
> +			serial8250_unregister_port(bp->port[i].uport);

Since it takes a pointer now, make it error pointer and NULL-aware

	if (IS_ERR_OR_NULL(...))
		return;

there. With that being done, all this redundant NULL-checks will gone.

...

> static void serial_card_remove(struct expansion_card *ec)

>  	ecard_set_drvdata(ec, NULL);
>  
>  	for (i = 0; i < info->num_ports; i++)
> -		if (info->ports[i] > 0)
> +		if (!IS_ERR_OR_NULL(info->ports[i]))
>  			serial8250_unregister_port(info->ports[i]);

See my point?

...

> static int aspeed_vuart_probe(struct platform_device *pdev)

>  	if (of_property_read_bool(np, "auto-flow-control"))
>  		port.capabilities |= UART_CAP_AFE;
>  
> -	rc = serial8250_register_8250_port(&port);
> -	if (rc < 0)
> +	struct uart_8250_port *uport = serial8250_register_8250_port(&port);
> +	if (IS_ERR(uport)) {
> +		rc = PTR_ERR(uport);
>  		goto err_sysfs_remove;
> +	}

You can get rid of these {} by using PTR_ERR_OR_ZERO(). Also do not define
variables in the middle of the code (it's only allowed for auto cleanup
variables and for-loop iterators).

...

I stopped here, I believe there are many similar cases which may be amended in
the same way as pointed out above.

-- 
With Best Regards,
Andy Shevchenko



