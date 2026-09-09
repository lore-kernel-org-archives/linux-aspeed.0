Return-Path: <linux-aspeed+bounces-4977-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252BDC79FB6
	for <linux-aspeed@archiver.kernel.org>; Wed,  9 Sep 2026 23:43:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgHSf30B5z2yps;
	Thu, 10 Sep 2026 09:43:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788942831;
	cv=none; b=muVZRtdS1oodjOffiKua5LgwT5kvKV1coW76IMFF4+QSCooG5WKs3ZKIksXuTyGDrWxp6scXVNIaAwEXtJqDCq4SOcwXSyrHKBmNtkV3JaSqLXkX738EeQcktSd5P2n59uWohLGvgAXv0YR4auXumfK+O5vdNKDZ4/sTe8hxveEuY9HIVjis6SCYhbJq8Rxbh8f/qEw6N/bPXR0XaHD9OJ7Nca1IcXxtEQ+1n2Tcva2viH7OCJ7P2bTc8RYEeEToao3tJRHzY8kYU5Mj64gh1VcxUJaFH4aCay4X4rGRCUoVR+nk5ErMl9y/RJh9OTbDIy5zoWJ62wL4tgLJZPvbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788942831; c=relaxed/relaxed;
	bh=mQsZ6aebHJQxMkqt08Wbinhh4q6wlMlL8C0i60RN04A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDRJFEhGXgbz/Hy9ET/D2mVCCXakQEMqfikrqTNoIjL7OnpMLnwoJPHs5f/eGH2Lci5AGpgrUzdaXzOyTKbc3L5eMMW4zcSk5xJlNZJQoVV6SnR0e8X6ogfGs5bbLbXB3+TCusdzk+8OpbsEcccNOExI2i3AM5aGNPQP+cEv0Vq/yk5PZM1Dp4hU4eReEJutxersIxXxas3Qscn5oWOOWtdF/+DTW5oZyRRW1EUzVxduXvx8oZXftzMmYqBtgxm7mSHzI+bGZTfWcFs0ONYIhlJvrSW9lIYCsVBVo8CSKzqSvEiJLmPaujgCTdCreN5g+FtgAR058qpz/sK4eEQVTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fy4iarGh; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fy4iarGh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvGl1kkGz2xLq
	for <linux-aspeed@lists.ozlabs.org>; Wed, 09 Sep 2026 18:33:51 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4A65840548;
	Wed,  9 Sep 2026 08:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69E71F00A3A;
	Wed,  9 Sep 2026 08:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788942829;
	bh=mQsZ6aebHJQxMkqt08Wbinhh4q6wlMlL8C0i60RN04A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fy4iarGhYC+fWRY4cqIOo4UckU2EIMXS943jL66BN3X8QLqdQmc+dpdmIZU3mx+dk
	 T8pBJ5C62jV4HmOpG+OzT00naRFeuSY7Dt0NFoGkrJLEcHNPk0kx8LGq0UVbEgLEcB
	 QeXk94WlbdJciaYl/0RKL767RGRa0jvIR1Bdw3Mdk3zGiuP3ByXJ7g35V+uWWZRQ2e
	 z/F4MCGVzPverSRjIrLLgnKo2+uRxovZkstb92Vg4jmWifuyQvlCa8bnhpDAgj0MWS
	 yCrOLtF8kMA9RgQuZJqK+zKNy2vWUIy9sxOXD6KWvc++TarkGv7Jz+lVE9EOAeIUNI
	 75C+c7kRhXn8A==
Date: Wed, 9 Sep 2026 10:33:40 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: aspeed: Document AST2700 USB3.2
 PHY
Message-ID: <sb34uqn5egc36c3or6mbhjj3k2sgcdxkdwnrberrnqzn7oqrag@75ghpc6cjmrp>
References: <20260701-upstream_usb3phy-v3-0-00e12315b6f9@aspeedtech.com>
 <20260701-upstream_usb3phy-v3-1-00e12315b6f9@aspeedtech.com>
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
In-Reply-To: <20260701-upstream_usb3phy-v3-1-00e12315b6f9@aspeedtech.com>

On Wed, Jul 01, 2026 at 02:58:17PM +0800, Ryan Chen wrote:
> Document AST2700 USB3.2 PHY. This IP is connected between
> USB3 controller and PHY module.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்

