Return-Path: <linux-aspeed+bounces-4258-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8ECCD98DA
	for <linux-aspeed@archiver.kernel.org>; Tue, 16 Jun 2026 00:16:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfSG62ggLz3btJ;
	Tue, 16 Jun 2026 10:16:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781568990;
	cv=none; b=ImHdhrJheqr1ZpBeCFWGu5va9oTedwsQE22goj8tFq+jmTQ5jpCL1At/oI7rvwYchEGedgN3n57iIljxP4r7wGZRObktxuhqQJihkLDmcLoATTmlyLUSWjn6uLpotxyHVJwWAbjBiy4vGUgB7QjTrq1KbeHS7dDIe/wx+FD0ShRgyrOqnULsl+Zjt1q18wf0KVJetwLzLXIpTVDMUGoywBkfOVm2BxpXoNbtFf5xKQxkwlAR6e6u3IsKUrsJXMuh9zgPxkXVFLiQHMDU5E15wwyujDgt33H++keFSKo5Qxy4zZY+NZKA6yJXEo62OrEN95pUJPFo4UcEZeOniipxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781568990; c=relaxed/relaxed;
	bh=RKUaFCacTQWmQr8n2TjbN4DQwtg9kdMWdI+WTObxrBA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FaAQS8TkgBeFWSiQ5HaOhskXb0Cp1BioSunYkNXFgCpmnSk5rZsrsTiV0n+Gxr+oOJ9936nsegGHsBNOFDw0Yj6nvE/LsvRKqAbsZNiCQDCVu/9Lfqe5t4JjZegjRnU9mejhllty+CDqfdwsq1mtZYvUx6k/KXXlOyTAQp39ITUGF34Tp04nfOYDh7RmwdElYdVCk/thoX79vA8WGS3HXofl5D43WM5jyz04h/KxvsrVbiGzV1hXX5f8SxPnNMW4huMHzrWHvxpqXTtPPJYUbnMWlY2HPtTSZDwsYBfh7Vh5yPPZtNohuA0S/UfY3qpWHDDQ5siZ/RAOgm9FFtk9ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=QMI/IHg3; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=QMI/IHg3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfSG52WWpz2yZZ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 16 Jun 2026 10:16:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781568987;
	bh=RKUaFCacTQWmQr8n2TjbN4DQwtg9kdMWdI+WTObxrBA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QMI/IHg3RKAmtHyfDwCfFr6Xt61lvSz8XYsLBaduQrmlCR0nvKeNRPKERL7At5v5D
	 7wlsCeyvSZikD3A4Xf1uDOqKm8vYDdBxzT5KOolMb1Wyv/m4M2YVa6HCeCkuC+xXIg
	 VrX6sz3C/qUV20c3y31b8DjA/MDIS9QMX6MeUOhQ02e//CGxBoEGqtQ60b6HdmE6vF
	 RFtbmNbJVI2RRKD3cmRv/BtpOP/JwvlTNyq+VCjbDr1RUM9MuJ854wQ6TAcn9wbAxH
	 UrdOf5/kdPd2QeLEm8zgemaE5lm8mxMCmLp0L9LLlY/pgAT2O6dcG3yBkBUCL4kwAY
	 AGcXesseuwIoQ==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DE1786001B;
	Tue, 16 Jun 2026 08:16:24 +0800 (AWST)
Message-ID: <e5822b82e99f8c2f81deecfeaea2192b223dfbec.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 1/2] soc: aspeed: add BMC-side PCIe BMC device driver
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?Gr=E9goire?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
	yh_chung@aspeedtech.com, ninad@linux.ibm.com,
 linux-aspeed@lists.ozlabs.org, 	linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, 	anirudhsriniv@gmail.com
Date: Tue, 16 Jun 2026 09:46:24 +0930
In-Reply-To: <CAFi2wKanAH+ekKz3eVtdiz=pjEvmKwSh1XhE-Xo7p=CCiSWpEw@mail.gmail.com>
References: <cover.1780929570.git.gregoire.layet@9elements.com>
	 <af322e76d34ad504e0bdec470293a017b489cfd7.1780929570.git.gregoire.layet@9elements.com>
	 <4839c31f666b612799a795bb47c884901fd2a903.camel@codeconstruct.com.au>
	 <CAFi2wKYzUDY5Gis9GaHdqeYdv-orHB+gWfLXkJBgbxfbnRgorA@mail.gmail.com>
	 <CAFi2wKanAH+ekKz3eVtdiz=pjEvmKwSh1XhE-Xo7p=CCiSWpEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

On Fri, 2026-06-12 at 11:21 +0200, Gr=C3=A9goire Layet wrote:
> Hello Andrew,
>=20
> Anirudh Srinivasan and I have found that IPMI over KCS using the
> PCI worked with the stock ASPEED bmc driver (the bmc driver in the V1)
> but not with the trimmed-down version in the V2. I have apparently remove=
d
> a bit too much from the V2 , but that's not what I want to focus on.

Sure.

>=20
> This brings back the question of where we should put the registers
> configuration,
> considering that two different functionalities depend on it.
>=20
> > It is also possible to put the SCU initialisation on the
> > 8250_aspeed_vuart driver
> > directly. This could be activated with a specific flag added to VUART n=
odes
> > ('pcie2vuart' for example) on the DeviceTree.

The concept sounds reasonable to me. There's probably some bikeshedding
to do on the devicetree property though.

>=20
> Similarly to this idea, we could include have the necessary configuration=
 in the
> 'kcs_bmc_aspeed' driver. This could be activated using a similar flag
> ,such as 'pci2lpc'
> or 'pci2kcs' directly. However, this would result in a lot of code
> duplication for most
> of the configuration.

Can you outline the duplication you're concerned about? I think it's a
matter of resolving the SCU syscon to its regmap, then performing the
necessary accesses?

>=20
> The issue for me is that, two drivers configuring the same registers
> is not a good idea.

I think it's not as bad as you make it out to be. The SCU's regmap
protects updates to individual registers under a lock, so concurrent
modification isn't a concern. The hardware design choices make all of
this slightly awkward for any related software design. As an
alternative you could implement a mini subsystem that relevant drivers
could call through to set the bits, but I currently think that's
unnecessary work.

Andrew

