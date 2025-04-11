Return-Path: <linux-aspeed+bounces-1178-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987D5C36010
	for <linux-aspeed@archiver.kernel.org>; Fri, 11 Apr 2025 13:06:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZYxll0XVBz3c81;
	Fri, 11 Apr 2025 23:06:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744376803;
	cv=none; b=MOSyWNnqQHz8vsNAEVVHMYcMUeZkfqnxdwX7p8LFATfX4G3ykzabUBjdx3NGlTWQyybzIYSMkSxpy3YJT5TyvDPpPqpKdLzr3/D545UI21S41DM2gAHpqsKymHzhUI0nFW1qhX8Zfs/fswfZLC6Z5/hrzIkGtkGSmjoiBpLtCLfDDHHrNyG039VITHtbu9SPhbjjp95y2uGsA8n7RYtE+spNYBRmk2gK/bZZ0NkV6d+rOqDRAWVhaG8n1RTXWg6uYYycRLtf0G7cftbQOSfdRFU8uNj0xrp3P9SfGxPMn4MhRnoQa5tLy5jHtSwROlhwrsB7+vHvLg2YUz/f9lo1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744376803; c=relaxed/relaxed;
	bh=n+npKFLH8wMm64bDctYCHs8oB5bTWNC0x6PimPO3Q0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRSiwdJJbwlHRS1xtx9THYnQ41zxmRbj+G64VLyGhvcPAlIgL51rcsFQ+vWKkxF3ffOi7nTd3uNQKRLXmMqw15hjyBzTtjglMN26FhgRRMUBypHmCt27cExaTMGMoUkneRNDlIunCoVeH3Klyie6PDSZx+XJlSOqgUhUCBI45ouKxetxrgUXCm1ugo6O1bfHrHxdzkbBf3uF/7aR2yotkwkiLXISblVyJuH9g7ORh6wLrYuUWfLJ6Y81yPZQA9daqrA6XHswcm3/wZB0XMNHrSXjp6qejMSxI5ctKn0YWWkw2hn7iE/KX3/YSBJy07l0rz+H+vZycP2anK0g0z0IUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oCHB33EI; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oCHB33EI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYxlj6wfBz3btt
	for <linux-aspeed@lists.ozlabs.org>; Fri, 11 Apr 2025 23:06:40 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E5F436845F;
	Fri, 11 Apr 2025 13:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506F3C4CEE2;
	Fri, 11 Apr 2025 13:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744376797;
	bh=5O79GdJMUP1u1auDATSqpr2gGJykXZlL0f4n5WLQaS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oCHB33EIcwBAAJPW7SO/vLL7mLGzXBClQFxfPq7Pgaq4qkNo00L4MAAaaVSAl5pBX
	 DJFRwHCd9ksWW1uOxVAsehLtq31xgQ1QykeaPmW3bkqaRv2Lb+R9tGQi9GUpUJKs7G
	 VvvXPitxaU4AHjFjlBLbtnqMzVAC89ik78+Jrdf0=
Date: Fri, 11 Apr 2025 15:06:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb/gadget: Add NULL check in ast_vhub_init_dev()
Message-ID: <2025041119-debit-cosmic-f41c@gregkh>
References: <20250405113020.80387-1-bsdhenrymartin@gmail.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405113020.80387-1-bsdhenrymartin@gmail.com>

On Sat, Apr 05, 2025 at 07:30:20PM +0800, Henry Martin wrote:
> devm_kasprintf() returns NULL when memory allocation fails. Currently,
> ast_vhub_init_dev() does not check for this case, which results in a
> NULL pointer dereference.
> 
> Add NULL check after devm_kasprintf() to prevent this issue.
> 
> Cc: stable@vger.kernel.org	# v4.18
> Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> V1 -> V2: Add Cc: stable label and correct commit message.
> 
>  drivers/usb/gadget/udc/aspeed-vhub/dev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> index 573109ca5b79..5b7d41a990d7 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> @@ -548,6 +548,8 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
>  	d->vhub = vhub;
>  	d->index = idx;
>  	d->name = devm_kasprintf(parent, GFP_KERNEL, "port%d", idx+1);
> +	if (!d->name)
> +		return -ENOMEM;
>  	d->regs = vhub->regs + 0x100 + 0x10 * idx;
>  
>  	ast_vhub_init_ep0(vhub, &d->ep0, d);
> -- 
> 2.34.1
> 

What kernel version did you make this against?  It does not apply to
6.15-rc1 for me :(

thanks,

greg k-h

