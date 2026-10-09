Return-Path: <linux-aspeed+bounces-5164-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015FCCA6012
	for <linux-aspeed@archiver.kernel.org>; Fri,  9 Oct 2026 10:31:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1NSh2Mdyz2yTH;
	Fri, 09 Oct 2026 21:31:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791541892;
	cv=none; b=NdFoHkA2qBl3NcBpXUUVCNfxMNMefcIZH++iFwRBJ7mNxe/QN2N2LzwSQfsRt1CnVefn1kUniABwIUG7jkQgkOuu65R1O3jE/2NqtwyqlmnPs6G2sDK0PxJchln0kRdWUbdN/0cQsbaOIiMTglGhypgUTeNqW7FHzZ9ZXg38nQF1edoSouupDfvT7j12aFR/y3fn3WllaHjYndXqKEeTRNEHeEidrhcLXwS6gG/TUFlhExO1OmFXPUwNmYfD0sO1uLvk7ANum7oEmhX8L6XCgHcaTZ0PuYIIcHw+MRC5sgdY4Qpf57xw8agpfiFAQBag4NWmbJ11JpaKDOWZofUelw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791541892; c=relaxed/relaxed;
	bh=g12nnmx2URm15ceIKI7TQ1hob+O8zuALvg+ycI7aBOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n11JhsotsVv/Qz+RsbneZPRJ99ViuSbajvwCKa+TwBg5+HHi2NnMtB/VYboMWZDjCvZYYVeJ0xJHt9/REf87mQfD0NdoNH1Q8COhSLLk+CVFEqtNr3eF1z2PTcrdWEVUGz2oYNZKpZ822C9eHVkLC8ZgzMz6gqzmF0jyzVU9SCXYPO3piYT0UBqI21f0vwyadcaWr5tCcf0H1/fM/8GXGyoPhOI3b2vWjQjnoE94AMttq40CyIp0tsQIIUVZny1LacpICFFE2oO5L23bqcptMt9q0PeGkn66HDDXJx1jDuY+3dc6TM8jmNqEcj28/GLHl8Ui2EcI/3gMUxj2R5gAhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K/kRAwFY; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K/kRAwFY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1NSg36Lsz2y1W
	for <linux-aspeed@lists.ozlabs.org>; Fri, 09 Oct 2026 21:31:31 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5D60860DBB;
	Fri,  9 Oct 2026 10:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B30B1F000FF;
	Fri,  9 Oct 2026 10:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791541888;
	bh=g12nnmx2URm15ceIKI7TQ1hob+O8zuALvg+ycI7aBOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K/kRAwFY9Q+MWWgCT3W+Q7iElzNrv5q3mGba5eAbc6Du5nrDbhqp/oigOYRxiacmj
	 9z2DF366U6XE8r7IyKSUN7iRHmRpidMGrqBMCqyUP79gV62mJnezWlYkx+jyqL51WS
	 6D4XUbh9TqgnTmejUj21EENabGH685/KDjgmrxURCp630//qOCi5V1ukDYraKdXFBb
	 e5I44YFaI0srFzYCgEgsF1LQ4QMIZrIygxeU/nCEWr3Ma6e570+40g2DVFx85JOpNa
	 tefA6Irn7hqOLqh4wO7bLvMM8XxrIvP6u2dzZcbB+bLAuO5GwoaD80UxkEjAddWmZc
	 CzXcukw7iQ08w==
Date: Fri, 9 Oct 2026 12:31:24 +0200
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
Subject: Re: [PATCH 1/3] dt-bindings: phy: aspeed: Add ASPEED PCIe PHY
Message-ID: <20261009-vehement-mature-mackerel-f7bc87@quoll>
References: <20261008-aspeed_pcie_phy-v1-0-96764937aef0@aspeedtech.com>
 <20261008-aspeed_pcie_phy-v1-1-96764937aef0@aspeedtech.com>
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
In-Reply-To: <20261008-aspeed_pcie_phy-v1-1-96764937aef0@aspeedtech.com>

On Thu, Oct 08, 2026 at 07:28:19PM +0800, Jacky Chou wrote:
> Introduce device-binding for ASPEED AST2600/2700 PCIe PHY.
> The PHY provides the physical layer used by the PCIe
> controller when operating in root complex mode.
> 
> Describe the compatible strings, register range, clocks and
> phy-cells value required by the PHY provider.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/phy/aspeed,ast2600-pcie-phy.yaml      | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/aspeed,ast2600-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/aspeed,ast2600-pcie-phy.yaml
> new file mode 100644
> index 000000000000..686b2e3d9457
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/aspeed,ast2600-pcie-phy.yaml

What? v9 here:
https://lore.kernel.org/all/20260115-upstream_pcie_rc-v9-1-d6c82a1556a7@aspeedtech.com/
from the same person, reviewed, but you ask us to do the same work
second time? Really?

Best regards,
Krzysztof


