Return-Path: <linux-aspeed+bounces-1628-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D36C83030
	for <linux-aspeed@archiver.kernel.org>; Fri,  4 Jul 2025 00:08:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYDWF5vXNz2yFQ;
	Fri,  4 Jul 2025 10:08:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751587721;
	cv=none; b=CNBaBBidRBbqo81LHekLBSUVC7Dk9AVIe9WGNadFbP8OvGtYFUe0A3uWhb3xD7XvUYVB5zVfLjTcWA6o6MuzYgr0P/3lusovb3D6Pt5Xv1VcmgRr4Fdi0bH2fFWC2KRXt1vqHMjvG3wQ5BRryc073G20xud07XuKtKDWLS6gvX7hG8XusQoMu/dZ8zaRJMsvXDmaDl2UPuy+7Kl+L4jrpqfw6lQKiBL3+Kas3I2y7J1e40TvKMrC4eVX/btIu7uKNdaAwHEhLgxEpY0W7Gby7NKCJ6lz1HSclHdgsVBChl3t2mGfsTm+I0HnqNtEG+FwActaFwYEgNcDI9pSJHzI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751587721; c=relaxed/relaxed;
	bh=Uy8XZzJ02bR6/cLFIl85KAvGOLEgWg6DWUi/tNsEDR0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UjgFmqmVG2kQc3/r/E3ARCi+TEmTassb2ekfhothaQ8BtMRPH5tUvgwzLL57QxolucWWri4StLd628exS14DHtDaEFHfCQ6XexBQBFGjdhwJGF3KJmlicJnu9F/zWTHCh/MUQNx4jo4Fd99bWitbKl0I78B1L8W1hRIuOERIdtxeR8h8Nt0zoIMt+FwC/cq+etmu4wjLI10XHuZ7TkGPZStAMGZhX9oHS+og2L1mrO0OF1hQ9QCo1AbK0374E+CFnwFLZRnwWS4Lx4d2ZBMIm/QVMs0BRgBfW19aI2ZiMh10K8W9ndqxJt4YEUH4CsEbz1a9TV4eKM+xv+hz7noSNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=VbNWFjfn; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=VbNWFjfn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYDWF2cPWz2xJ1
	for <linux-aspeed@lists.ozlabs.org>; Fri,  4 Jul 2025 10:08:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751587720;
	bh=Uy8XZzJ02bR6/cLFIl85KAvGOLEgWg6DWUi/tNsEDR0=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=VbNWFjfnAw6JAM00tL8QlNCUSMyQC4wsOMYG87a0BS/RcqCNry9MKPqrdlXpqZ+w5
	 ryflkTuHIbD8GKeViQ9QLUcwRDEv4o+t3/79+1g6DY0bwzskpW2lgQ4kcPAjeaWOKl
	 CKrFj9Wemd4fasKclY4tOG6JsAy1L1l9PeplYcbTgLN5rc4JcK5VcEs+ol6GEoCZtE
	 G6x16Lk5bo9qmGgklOo4J268zklnj9D9g0z3lgnT30lk2cRW/IPsJXSV0uUmVaNK3S
	 eiqE/yJKPWKOU345NOar29/amv8Z2CKCpu8hPtUwrPVDV9CHehDbsgiyWFF6/iCW6F
	 PrUOLpB+kVgoA==
Received: from [192.168.68.112] (unknown [180.150.112.153])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1B7496A680;
	Fri,  4 Jul 2025 08:08:40 +0800 (AWST)
Message-ID: <94e0c5bfe1239e7590cef427cbba405077d56d01.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/5] ARM: dts: aspeed: Remove eMMC from
 ast2600-facebook-netbmc-common.dtsi
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: rentao.bupt@gmail.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Tao Ren <taoren@meta.com>
Date: Fri, 04 Jul 2025 09:38:39 +0930
In-Reply-To: <20250702050421.13729-3-rentao.bupt@gmail.com>
References: <20250702050421.13729-1-rentao.bupt@gmail.com>
	 <20250702050421.13729-3-rentao.bupt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Tue, 2025-07-01 at 22:04 -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
>=20
> Remove eMMC device entries from ast2600-facebook-netbmc-common.dtsi
> because eMMC will be removed from future Meta/Facebook AST2600 network
> OpenBMC platforms.

Please squash this patch with the subsequent two patches so you don't
break Fuji and Elbert across a bisect.

Andrew

