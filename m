Return-Path: <linux-aspeed+bounces-4978-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A63C79FBB
	for <linux-aspeed@archiver.kernel.org>; Wed,  9 Sep 2026 23:43:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgHSk2tSzz2yys;
	Thu, 10 Sep 2026 09:43:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788942766;
	cv=none; b=LTsEfoRtSVGn/7hGKSODR6hlby+CXqUyhaUUdmldXS+nhfNwfOIccjY9hiFwSRZmBLSXiExb3mEBbdQ8L6vjaqoExJ/qyTJ4ClNjLe0duStD37ZOrx8lcPbYCWYAPlgZq4seWgxJWUAWyXSz7fTLsCq1iJiU8PWD9vAWMZNEo8nbs5TSTXMVPB6L4oIB5FkuQOJfNE5WmRcbauVEg6OJ1d2jXFrr0oRqFbD3BPNrzSpoo7gZBgC/8FJzAstY/U1ZL1SyrK8xri5H6wn0vvkWIcnbqFTcE2SGiwecK/F+YnuwTOdcq5gICfyDlj71y7M1vyDsbh6MZuA7dUSjxh9k4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788942766; c=relaxed/relaxed;
	bh=58EOD7l2qHE4wo91y89rSgzwAVP6VfLV2rivV/mwtnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7YTWFbdFN+dvFETtQyseurk98ybLCcRgetLinrw8gkjvGHc9U8weDJR4smhtCPZ9cWHm97jT8Gdi69EDz+M7JmeBN5DFI9kuh/mXvnns52Jg+C7dWPwrngvmVa2epsEFQ52B40x9a2RWVX75RO3QRsOlcVwgaLe2q11vUvG+6vyiEbIsgFxxd4WWOizDkx6kYZRqqeGqNkutY7ZxJNsczzuOmgSS75Bzfe7k8ZOUJWhTUsydIVNdmB3qnN8DQ8+HrSr1zejosdeZnGt6/6hzqPIohSBgvp/dFlyYKUt/1HXLr0RQJ+eKjSQG14bs5uFXsbaXULDyYmbbBcmGWAdFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsGcn7sY; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsGcn7sY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvFT4ZjSz2ynZ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 09 Sep 2026 18:32:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 67A20601FD;
	Wed,  9 Sep 2026 08:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A793F1F00A3A;
	Wed,  9 Sep 2026 08:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788942762;
	bh=58EOD7l2qHE4wo91y89rSgzwAVP6VfLV2rivV/mwtnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CsGcn7sYULHd2mcLbyjwpT3LIq0q4Ly0IxF2GVkacWdp25tdv+mGcpYRhpB9b3RF6
	 PftG00HGRHpsifnw6g5l83/NkOvQTHQU+hBWfxU5bZFPm35kooW6gH39gvp98mq64p
	 peeyLmPelCLv5E9IqPU6Oo0vfhlpikra1NvNFnNNKeIEatOhm7aGBWeRbCFtCrJPrd
	 UOQZxvzk3s+olK3OxQRk9c78bindNkxZ0sJkxePam8HON1PDwYmt2vBY9q87J9YNEc
	 GWPrZEPPfglxp0/bFGJED/97vFrQLXHZa/HCuxCm+R5W09sPtVb5O3uQ6w8/X4IJmt
	 7xTrRRT3UPMgA==
Date: Wed, 9 Sep 2026 10:32:33 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Add ASPEED USB3 PHY driver
Message-ID: <eizuwdemgc535gutiq3drpnxkqlw2c4a5bgjmjnnoe52lrbpqa@3p3mzanalcce>
References: <20260701-upstream_usb3phy-v3-0-00e12315b6f9@aspeedtech.com>
 <20260701-upstream_usb3phy-v3-3-00e12315b6f9@aspeedtech.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701-upstream_usb3phy-v3-3-00e12315b6f9@aspeedtech.com>

On Wed, Jul 01, 2026 at 02:58:19PM +0800, Ryan Chen wrote:
> Add maintainer entry for ASPEED USB3 PHY driver.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்

