Return-Path: <linux-aspeed+bounces-4511-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B533BC4452A
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Jul 2026 13:31:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3hHr6WCPz2y8F;
	Mon, 20 Jul 2026 23:31:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784553441;
	cv=none; b=cd3Q/Wrq5QIqpoW+QPjrTZjq05DLcy3MzLS6+d0g2ie0qQvt0r7XuNmYGibOmHtok2lEqbx9j0ZPMYbNlRcYOiXKFEv/CZWf2IB9SNvC9DvKvyLvrPx/3UbclLxZ60V8hDsN2b6P6TKs6+ZWYVeK5Au/QphG+6AXKIkownDvTkCvB6G/9RCws2N8bMD9gsVgn/SyNFbFK9mUMura1re0NO+6W3fFF2LntMcgm+r9DykY8Grf+wDq5O/ZxsN2tuY/4S/I6xlb8NhcUKeb5HuwMgOw54u/mT6juxzRz0P+2KSXrHmvFavo+sQcrdhCKY+urTGgUsQHW2otas7lZcyvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784553441; c=relaxed/relaxed;
	bh=QhC99x7vdLxugeCtGkIpVFaFlhQmyHyfood4QTosfNY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=omX/tzXECzkdEZP5+aLZ41PNNqzjkP7Isk6RPSwz0nhhLF+TS1UWRzUUVx3r8/uIF29wdiJS3d5pA+ja5Y7gTpCUVDSeWDCKXPliyJV3o5dkVDmijYiNfFA/DWbbYNZLtfa0mkl5Y4qOpXQr60MVwIlwMfTQs/pJ5LdYTl0IbVC9R5cqsgdsCLXCggjqW061ne5xzNz6s4m0M1KtjvmgVwO5qMiSeUhMFAM+3Q3agZxbBsWSiGtundF5aqPQ7QCeX75h+zKSPIvSEWTNQFTN5ceEDBj457qiaX/gz9I5/7KbPH1Dg7lUbccMHABOLrMN6Uhzflh1Q3+A78LARcxJiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ekx0qK/S; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=gd/7=fo=oss.qualcomm.com=manivannan.sadhasivam@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ekx0qK/S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=gd/7=fo=oss.qualcomm.com=manivannan.sadhasivam@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3gzN2hj9z2xlZ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Jul 2026 23:17:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D114B41957;
	Mon, 20 Jul 2026 13:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AE71F000E9;
	Mon, 20 Jul 2026 13:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784553437;
	bh=QhC99x7vdLxugeCtGkIpVFaFlhQmyHyfood4QTosfNY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Ekx0qK/Srb8oSP2eKbdTYsBPRyxMt/d9O3yjxos43A26fm14PVGfA99xc1oFaUNRH
	 t33/CXj4ytIGGRt26MnPn2GM3yH32lCmh3J0EUkGbmryEjN4mrgRsZ1tpDtOEQz8Hy
	 4QxR55IuxVkS02SgFKDZ0WSYhYKgc5DcDIqZdxqSMJFZQdRInsuvu+Bgit/wx0OEby
	 YB/2d3xzxjXnYSDAahvKQRQ3ewu3NupVczdRvQXI6TDe7ApQsF5top5L4+CsQ8icyg
	 SD8vyge5RQ40E6ems95LfxdFijgsxt98ytN7q+tX8TcxRtqAt0KzwtjH+5GJDO/VvS
	 85f/TrAelG57A==
From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, 
 Jacky Chou <jacky_chou@aspeedtech.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260708095814.385480-1-jirislaby@kernel.org>
References: <20260708095814.385480-1-jirislaby@kernel.org>
Subject: Re: [PATCH] PCI: aspeed: Switch to irq_domain_create_linear()
Message-Id: <178455343360.25926.10984869704341739230.b4-ty@b4>
Date: Mon, 20 Jul 2026 15:17:13 +0200
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 08 Jul 2026 11:58:14 +0200, Jiri Slaby (SUSE) wrote:
> irq_domain_add_linear() is going away as being obsolete now. Switch to
> the preferred irq_domain_create_linear(). That differs in the first
> parameter: It takes more generic struct fwnode_handle instead of struct
> device_node. Therefore, of_fwnode_handle() is added around the
> parameter.
> 
> Note some of the users can likely use dev->fwnode directly instead of
> indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
> guaranteed to be set for all, so this has to be investigated on case to
> case basis (by people who can actually test with the HW).
> 
> [...]

Applied, thanks!

[1/1] PCI: aspeed: Switch to irq_domain_create_linear()
      commit: f944349dcbaeaa9d6e1c8f2f8182f5560ba79581

Best regards,
-- 
மணிவண்ணன் சதாசிவம்



