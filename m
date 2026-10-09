Return-Path: <linux-aspeed+bounces-5165-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AFDCA6019
	for <linux-aspeed@archiver.kernel.org>; Fri,  9 Oct 2026 10:32:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1NVC4bSYz2yTH;
	Fri, 09 Oct 2026 21:32:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791541971;
	cv=none; b=Z/VAxEJi4ggZZVKtFsywp4UTbKgYu/0iWDgHmtAGEV16vWl2e/jrFDUz70VhpgOo9k26kQ4SyOm8munG91CCNoYGS/CcO5Cndv5Zk3mCheq5uhIO2BhB6PGErz960AfusK8TgweBJz7aDFlsgZQSdcDIVNQisrZg9IXCT9A4H7fLr0yoY5Fb0I1EviMs3lSRDWdz5i9a5lyfuP0qTJk/xLzBws0CQaoFBdGlyq+b4jLG9Xav0lrny8JdPZapmsvlE308g/oz7x8arXhqE0Mi9184wHs/Pkyv17pVL9+uXJc3hEnr1Y4Kc5SMsXjCrmHQLy3Peq0BekPntY5Gq/OqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791541971; c=relaxed/relaxed;
	bh=Fz4v9C4NJeucclJ4dP4f/7Y/qrP44cVlU8hrb155EX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DssEzdkKx4hdMuG4FQeU9D5aADSNA9o7aZ+qkWoT8CrScGqFoFlTzazhcDTF/jfGZ0ifDChyaru9tRS+6h8TErMINmXCyXGvOBjx5IQgMR11VKGleOiJYPdWGXJR4LGWHi+9SEWFez3OeUvWTTRiTeZO0G8SAtoV3P9GIyIFPyhlFw8tYX7QZluKbfoKc2zqxa4xvxPt4WkJy465NhsCquuV+x1l3aVpFhM5R82iCRK9VCsOKEhaQQA1LAxJoYxGWc3vNFr9JH/ZzK+kljHafyYNqJHSZOcyrqFrS6cmbr3YqvrFh7+xLuBBTE78nFEn7k0brC5aHExpC7PbzuaA0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlRHztSP; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IlRHztSP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1NVC09jWz2y1W
	for <linux-aspeed@lists.ozlabs.org>; Fri, 09 Oct 2026 21:32:51 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0F21E60DBB;
	Fri,  9 Oct 2026 10:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7EC1F000FF;
	Fri,  9 Oct 2026 10:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791541968;
	bh=Fz4v9C4NJeucclJ4dP4f/7Y/qrP44cVlU8hrb155EX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IlRHztSPGHLNnIEqKiOzckUamhY3gEriL98qwKunMtuXg52gXtbU/pABUzt1GmZoi
	 bsPPguajRRS2afjxnAXk4Mh+XMPrXcQ6Z5dGzzyWWkjM5aqpcVOEwS5c+p+VlgxJYk
	 xqsPDgkAJRl1bJjife2FkYh+f+DpEgHcWj1so7nfGyMXqwTzOe+fiGJoDc6tXYl8+a
	 OOUjJ7O2ovUus+WjJRiJQCga2LHfjk6v3IghycjItQMW84hfawikzlzZpLx0yPs6Tg
	 86TlwUso9zQAxtapPRSHlN+Y30z33bcpJ76knV38aZgiLA5a8EZGpH3yOcjKkx9VlR
	 L2LWs8SfGPnFw==
Date: Fri, 9 Oct 2026 12:32:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, linux-aspeed@lists.ozlabs.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] phy: aspeed: Add ASPEED PCIe PHY support
Message-ID: <20261009-vociferous-puma-of-amplitude-1c4dde@quoll>
References: <20261008-aspeed_pcie_phy-v1-0-96764937aef0@aspeedtech.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261008-aspeed_pcie_phy-v1-0-96764937aef0@aspeedtech.com>

On Thu, Oct 08, 2026 at 07:28:18PM +0800, Jacky Chou wrote:
> Add the ASPEED PCIe PHY binding and driver for AST2600 and AST2700
> SoCs. The PHY provides the physical layer used by the PCIe controller
> when it is configured to run in root complex mode.
> 
> The driver registers an ASPEED PCIe PHY provider through the generic PHY
> framework and programs the SoC-specific PEHR registers from set_mode().
> For AST2600 this selects the root complex port type. For AST2700 this
> also configures the posted/completion credit values, local scaling,
> device type, internal reset selection, and downstream port setting
> needed by the controller.
> 
> This series also adds the devicetree binding for the PHY provider and a
> MAINTAINERS entry for the ASPEED PCIe PHY driver.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
> Jacky Chou (3):
>       dt-bindings: phy: aspeed: Add ASPEED PCIe PHY
>       phy: aspeed: Add ASPEED PCIe PHY driver
>       MAINTAINERS: Add ASPEED PCIe PHY driver

And changelog plus versioning are completely missing.

People sometimes wonder why maintainers are grumpy. Easy answer: you
do not respect their time.

Best regards,
Krzysztof


