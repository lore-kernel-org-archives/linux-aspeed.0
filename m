Return-Path: <linux-aspeed+bounces-4182-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB15CD6E57
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Jun 2026 14:30:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVqqm6vd8z2ySJ;
	Thu, 04 Jun 2026 00:30:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780497044;
	cv=none; b=imEaKgvjckJM2l8tjlf2RJiZ5vpQ0GtYZy7hY9CidX1bQ6Br104MAV48VYMupDLUQStglqgqMHAwIhAWgW4vwY2w2xg+8R3i8XXo6Y/IzypazxaIsoNZ++ttqptVErPbFkkOVG+t32eMB3AuqBFQGgqfwjlq2P8PcVEP+rUqtgpR97ONKl3brncypJPYM5+5xvkgicFpaQIQiEfKJPjs7i9+YjIqOFySGitmP4O+TyQHgfAl8coz8NpC/Gry2neY3xMO0+HpooBXPptQ0mlDEXTxn8n3muWZARikhjrkQIMzcLVtY2O2J0fhi/O/nr376T/FHiCSvJgKRCCTZOZSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780497044; c=relaxed/relaxed;
	bh=0MVJMXi2QyaRCfUW1Qmmea847UYJlY9Zkjowh9hCULk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0eSkfhX6V/zMrHQIqOu+MlIQY2WBmtVwIGtXpuit5E/EUq8c6NTu8oGgFMKa4x9sRGCV2+4+5J7o9+bL0etVEjdyET23UUZBWjKj89oc0bLpayMZ1RqsLI/Df5rRNd2UzbyCShL+TtBA15ao1rKO9oG6Ws+26ORW8iWc2RyVMQImPlobLCBP9b9h0+pdDXdXFTbHvsycY+hpp1re0Ow1xkkzqD0iN0xskW1oXQthrp0+RlKhJCLVTe/5nZaGkSSRlUBpr9IvMSdJmBhhtw2U+tiaWvNjskpop0TD5d3FRxMr2qaG8g4gZsmHIPB+00OQSDKSrTV4hBOThSzrkUzOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Y/8LGKNG; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Y/8LGKNG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVqql0s3kz2xk7
	for <linux-aspeed@lists.ozlabs.org>; Thu, 04 Jun 2026 00:30:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=0MVJMXi2QyaRCfUW1Qmmea847UYJlY9Zkjowh9hCULk=; b=Y/
	8LGKNGbG3UsqrQliqHZ+ijnkvui8eEQxiei6BrUGnxP7nAuEWbbyTPCjFHr655ZhzkHCfvUlUDIKk
	ewaoILwGh6IQzK0ApJoPwAJRDC1HQWHxTIpROJKtIB0PJUZHPcTQe6UR6vYQThNeo+EtpmB3vBAS6
	ClkP1SC3b46tan4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUmbv-005tKC-1C; Wed, 03 Jun 2026 16:30:23 +0200
Date: Wed, 3 Jun 2026 16:30:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Gr=E9goire?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com, ninad@linux.ibm.com,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] soc: aspeed: add host-side PCIe BMC device driver
Message-ID: <77464543-f793-4441-9fce-8666ba1c3d66@lunn.ch>
References: <cover.1780409151.git.gregoire.layet@9elements.com>
 <a8e1396af1b6db38bab13383c6ba303e8427aefc.1780409151.git.gregoire.layet@9elements.com>
 <ecc3bd49-829f-49b8-b3b1-4f16363ea5b9@lunn.ch>
 <CAFi2wKY7ECbxSbtsO1W9KEKFET67yKg+C64jtQHFY05DRzhfKg@mail.gmail.com>
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
In-Reply-To: <CAFi2wKY7ECbxSbtsO1W9KEKFET67yKg+C64jtQHFY05DRzhfKg@mail.gmail.com>

On Wed, Jun 03, 2026 at 03:43:36PM +0200, Grégoire Layet wrote:
> > How virtual is this? Is this directly accessing the hardware via
> > shared memory? Or is there software on the BMC which traps these
> > reads/writes and responds?
> 
> The VUART is virtual because there is no physical UART link between
> the host and the BMC.
> Instead, the AST2600 exposes a 16550-compatible register set on both
> sides (BMC APB and PCIe host MMIO).
> The data flows using an internal 16 byte FIFO shared between the two
> register views.
> So it's hardware emulated and there is no software in the data path.
> 
> The AST2600 has four VUARTs, two of which are accessible via PCIe MMIO.
> This is based on the following section of the AST2600 datasheet:
> III.48 VUART and III.64 PCI2VUART.
> 
> Because the silicon presents a standard 16550A interface in hardware,
> the existing 8250 driver works without modification.

So tell us about security.

Is only this UART exposed in the shared memory? So the memory window
is 8 bytes wide? Or are there other peripherals also exposed? How do
we know the aspeed is not using the UART itself? If two drivers are
using it, are we going to crash one or the other system?

https://en.wikipedia.org/wiki/Core_War

The advantage of rpmsg is that the aspeed would advertise what
services it is willing to expose. The security issues are different,
implementation bugs vs exposing bits of hardware to an attacker.

    Andrew

