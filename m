Return-Path: <linux-aspeed+bounces-1159-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ED8C36010
	for <linux-aspeed@archiver.kernel.org>; Sat,  5 Apr 2025 11:08:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZVCQT0YL9z2ygn;
	Sat,  5 Apr 2025 22:08:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743851329;
	cv=none; b=JMJWqrSPjJD+IiZ0RkamUS8PnQha07+y+U2U49agcqaA64BS2DCTK9yUn2cS5CA4WcdXydg/2sXSCWqTKXFpweUel8dwRr+AnSqMT4tOs2C3Lev9l02is8lFTkbhi5qC2SZib81c5zxgcukW+fYwVs05J26Y1chWSXu+xEAIqMILcagOCV5PSOQcpkwW6LsV3Ceaanl0t/FeC63KNbvJOo4C8DEyZQJ4kYTudQNBUpwB0nplwZwSEoGBcWt7qSSb65vPTsgXeaqK9dZCFdb9nfNOMYnI8mN9gs+m/yqBhu46I9twCi+n9IGZhlmu9CiVQ29JjVZ3AlaBi3F99CXukg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743851329; c=relaxed/relaxed;
	bh=Vya8iaw7Anhfwsf5FS132RTtxwL4SCtVczzoO4BHfVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gj0YVpIwmYQ0HXnCSrcbUHia/b481ojeyn9jNixK4ug0loibgwtRFohu4SwprH0BkLUvk/c1y+dMEy7nORaTQr5kQ7climfyizQc1HurzCRKVn4HDAYKO9QwSrVA2h8gIQizKNOE/02bwYaZDXOK0/PoiVmlj4uxm0lIzZffQrILVpWLk2kupbxkl6dc2feeFhDrgF5hPukr8cMInPw/POfN5EnpmEwKdcvWnts7JU8Ro86GTg5SzyISuAAFU9f87rVdEgQBETHtI1IFaXxKP3iY7Le9WeqMcDPr5/RelJWlTD7nfAzXQ4srhK80JWJneXclo2zaXJnIQ+hf4ZDSbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ANM4kS03; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ANM4kS03;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZVCQR3v3qz2yN2
	for <linux-aspeed@lists.ozlabs.org>; Sat,  5 Apr 2025 22:08:46 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 00E5CA42FA2;
	Sat,  5 Apr 2025 11:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2891AC4CEE4;
	Sat,  5 Apr 2025 11:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743851323;
	bh=dezxj8VSTZLrhrjMvBNRo9xpOTdQox3P2xIB/cWe9ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANM4kS03MtTUdM32rgSWs9YpCS0CGFaMqXHu4IKzHuAfwLypIYNdLmV/vR36aA0/U
	 cELzkwwwuV0gKzDs/uYnYx0TYaiD6GSfh+OAWmz+xCutCfhyxqj1ohLctBXjCLWPC/
	 93hfZf4v++soFdMTZC11JQK/O73giTWHHilMaRG8=
Date: Sat, 5 Apr 2025 12:07:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Subject: [PATCH] usb: gadget: aspeed: Add NULL check in
 the ast_vhub_init_dev
Message-ID: <2025040527-recite-stunt-893f@gregkh>
References: <20250329002911.132826-1-bsdhenrymartin@gmail.com>
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
In-Reply-To: <20250329002911.132826-1-bsdhenrymartin@gmail.com>

On Sat, Mar 29, 2025 at 08:29:11AM +0800, Henry Martin wrote:
> When devm_kasprintf() fails, it returns a NULL pointer. However, this return value is not properly checked in the function ast_vhub_init_dev.
> 
> A NULL check should be added after the devm_kasprintf call to prevent potential NULL pointer dereference error.

Please properly wrap your changelog text.

> Fixes: 7ecca2a4080cb ("usb/gadget: Add driver for Aspeed SoC virtual hub")

No cc: stable?

Also, your Subject line has "Subject:" in it twice, something went wrong
with the patch when you sent it out :(

thanks,

greg k-h

