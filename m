Return-Path: <linux-aspeed+bounces-5133-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5B2CA5FF0
	for <linux-aspeed@archiver.kernel.org>; Mon,  5 Oct 2026 10:21:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hywQX70mQz2yDm;
	Mon, 05 Oct 2026 21:21:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791195668;
	cv=none; b=CbeQAEOi5QWQ8fBMIaocOrMJa0J1fkBnfyINOOUnjfs+EKdRdIiLBUgcz7KNnJ2RgGlEKc14QMHbp198bz5IOQVqqUDX8Uey0vvh/CWpeyaECvf24qPAHpyCkwBI3+PxdTFVcHfMuXZhxs0y91n3KSK1NfFtQ5/lFyQZRwp4FOfGuBgX9hYUv83BrVeUJ8wTDt8IZzK5d7R5jXqYDDsp8I2rgCtOZvkzzN74FnC0yCxIFokWwtY9EezfpG4LSpaaw29P7FAfXS5cmtcu1lrfdKj3zcuVAVMq+e5c7cbyq1AwzRX77zMEXAyqq+IIJInUEUIW4LP1XXTeYhOYzJ0MCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791195668; c=relaxed/relaxed;
	bh=wjjeW5yegDf0KDKbY7d9B07KRu5nvSc+73Tk90wGuNM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l+GU4P23TNfdRBUyaNjkeA3U7SFIUqbG9Qd1K5UCRxwIEsoFGNrIb9Rh/DPqfFqbNBBVRFB9eYWU9HsFLqsDH/sAmVnzjCy3d8sppDz7wHBRT/QUnLdyq/GH3xvPQd07vDGNoNQsAbX1w1Mzb9SOQHJc65EDs1FJ/zl66i+EEqqdgKAP6EhJb5ToQ/bxlxDinLCEiCDShp8++SO+2JJ22LIbADA89Xz6/FdFGvguPEF+pFq33xNyFjwIvqY9/06RYtPCU9gSG9aonWbW0G/Probhs18iDJlSgZeNfGTFpx2MtDasbSdNxUYrdkHJNoTCMFNqw18SYxf2NvP2JcMt8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMISnwWY; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMISnwWY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=vkoul@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hywQW3TRLz2y8G
	for <linux-aspeed@lists.ozlabs.org>; Mon, 05 Oct 2026 21:21:07 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5CD7043E5C;
	Mon,  5 Oct 2026 10:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AEB1F00899;
	Mon,  5 Oct 2026 10:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791195659;
	bh=wjjeW5yegDf0KDKbY7d9B07KRu5nvSc+73Tk90wGuNM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eMISnwWYbwAjJzdqTp1EndL/6YzWzvZJSug5EJGr2jtZNIZCGvgQUtOo/AsJAiCYr
	 +E1hnYT4xvJiCYwADhkmpjBg6fl+Ja7L26Nq440OorctF3IyVDx4uQpKqf8bQXiEX8
	 zUoCno7H9tIc0pwRXCIX1Nzzqd6u2NnwYfMMOw75ynXo84/V7vrrjui9gQmfz6ZbHT
	 BzibSNnRobFRMCWdHNiODMLdDg+pYWFhco2mWIfJWroxsstHwYsPgNEG3VobYxdy+B
	 CeWOQJudndNmaZjWZC//p4aa08U/ZkdhTQYUX90ZddAQSIbmCpFUPDAGGpfXUEzmdb
	 1ZSePukef936Q==
From: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
In-Reply-To: <20260916-upstream_usb3phy-v4-0-812e76037d01@aspeedtech.com>
References: <20260916-upstream_usb3phy-v4-0-812e76037d01@aspeedtech.com>
Subject: Re: [PATCH v4 0/3] Add AST2700 USB3.2 PHY driver
Message-Id: <179119565537.316652.120525327400272705.b4-ty@kernel.org>
Date: Mon, 05 Oct 2026 12:20:55 +0200
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 16 Sep 2026 08:38:00 +0800, Ryan Chen wrote:
> Add AST2700 USB3.2 PHY support.
>  - Supports Super Speed Plus Gen2x1 (10 Gbps), Super Speed (5 Gbps),
>    High Speed (480 Mbps), Full Speed (12Mbps), and Low Speed (1.5 Mbps).
> 
> 

Applied, thanks!

[1/3] dt-bindings: phy: aspeed: Document AST2700 USB3.2 PHY
      commit: e22b112f2fa565fd7d2715ac9d1bc3ba1a3c2427
[2/3] phy: aspeed: Add AST2700 USB3.2 PHY driver
      commit: ad72aff5b4b5396a2a443a8f838fcfb8067dc603
[3/3] MAINTAINERS: Add ASPEED USB3 PHY driver
      commit: ea01f446f0682a5e7bd7a275889a890b7e0c6e02

Best regards,
-- 
~Vinod



