Return-Path: <linux-aspeed+bounces-4195-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB3FCD6E79
	for <linux-aspeed@archiver.kernel.org>; Mon,  8 Jun 2026 18:05:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZ0MR3m9tz2yS4;
	Tue, 09 Jun 2026 04:05:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780941939;
	cv=none; b=lyI2e9blIMthm95NK4bjmI1AWXnwGzP0Ou0CmpYqLDbI0huxNRf7cP+JH1yf5fQlYaAsN1+fdNo47MtUjfdC+39Ddr7wAukFut2VFc3wCmvAYy4bbu6EWE0NgyI4+QgKXipvox4sLRngIN+rd/k62X+RFhQEQ3zZxXqrGfmjCMfiB9Zr7LDz3lgYY3lrmsrH3Zk8aQOxghEGkP8/BZs8TWMePZcZybmMCoOwKrFy4jzzuxU5dcMHdE9gKShGpSjknmpenUHEphFAANnXZ8CFymdsDtdaThoFkbs+YDpJfgk5xmT5tuTalgDFgCN1PBHnusPZ5pAfp9wNz4AixMzlOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780941939; c=relaxed/relaxed;
	bh=Sn2RaqFmcO0Fp/dqSoOY9ViKZkuBRw2xZmPal61BeyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnfBZrvfJ5qgrS93N4VFueo2D4UUysvO9AS+OB4uQzbbK5PElWMZRhApEw5nep02HLsjmNKjIG5fLHXfonlOMcTWHDQxbNQAINWGs/7XideQ9/tiYZk8qFaRrGM4rAG7HqcsRgFtwNEalkU7b+31Y2j3H05j1wMr19P09GJyn+oQg3cOpVXL58oJSt4RQE96s3B9Tt0eTx5Dw7Rtv1b52O1Cv9VKzpdR1CuM679kv6xd6QugxKuF2MFDiQQkSTAjFIC9S3w8fPYuMkVhdUHZ0csczsQN3n1k40g92TG9BNpAC+5Ifa9se64HhpwZ2ayQvjDgcC5bXELA8C/PHdWBkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=SAvCiCFZ; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=SAvCiCFZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZ0MP2lpjz2yS0
	for <linux-aspeed@lists.ozlabs.org>; Tue, 09 Jun 2026 04:05:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Sn2RaqFmcO0Fp/dqSoOY9ViKZkuBRw2xZmPal61BeyE=; b=SA
	vCiCFZUrJ17FzKwxMlb28P7G5IGDkYRRug9aPlaq3G9S0tgrGiJy+GeUYBK1ANKZSaaL9QXPIOt3P
	ShNPGt/bzWyI8W5vFzcqp5n7q0IzyceAa5294Eo13qn2KcaD9JiZeJsCx+KsZbD+KkclbIyAOSljD
	A+gF0/JjC2GiX2k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wWeLd-006fu9-6O; Mon, 08 Jun 2026 20:05:17 +0200
Date: Mon, 8 Jun 2026 20:05:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Gr=E9goire?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com, ninad@linux.ibm.com,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] soc: aspeed: Add BMC and host driver for PCIe BMC
 device
Message-ID: <63654bb5-c246-41c4-bb7e-5bfa23e59f2e@lunn.ch>
References: <cover.1780409151.git.gregoire.layet@9elements.com>
 <cover.1780929570.git.gregoire.layet@9elements.com>
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
In-Reply-To: <cover.1780929570.git.gregoire.layet@9elements.com>

On Mon, Jun 08, 2026 at 02:51:21PM +0000, Grégoire Layet wrote:
> This is a v2 for upstreaming the VUART over PCIe BMC device driver from the ASPEED kernel SDK (branch master-v6.18) [1].
> There are two drivers: a BMC-side driver and a host-side driver.
> Together they enable host<->BMC VUART communication via PCIe. 

I would like to see somewhere a comment about security. From the
replies i got the host can access anything on the LPC bus of the
aspeed. What are the implications of that? What are typically on such
a bus? TPMs are often there, but does a BMC have a TPM?

	Andrew

