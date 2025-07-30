Return-Path: <linux-aspeed+bounces-1862-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C79C87FCB
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Jul 2025 20:55:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bskxz1r06z30Vq;
	Thu, 31 Jul 2025 06:55:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753908935;
	cv=none; b=joH6RAX3lqGxlrn1A6iVaCBbB/HMigv+ht7/FGeOd4bAkF3nv76THCEhkAnAMI2Mu7aJXvc0WeNH3XS1E7YaLSDr87MGxS9YsdFVAztU8q1W0Rj3ZW9kYFN6FUkoqon1/2dxSUCeiW7SxPBlbm804uK1En9gOCLuKOHc6iJCyMx1I/mfyHGLQhRlq3POWh6d2vK7xfQG/geYGcyFg4p1X7hwrfTYZ57JKEy6vvVOxf5KWYcscSeIXNntez/s1axqhI5i/cOugxaGoxZLeQAdNe8iLkz7C2I696biQyywWD1miq7RcXkf5d7rQ/ZdAyJWcHxGad9gSwtXJ2FVAftQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753908935; c=relaxed/relaxed;
	bh=9xwym8ZPyeCD78WBbowjHHZjt146CBwMq7OuJ/UiDTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cn0L9QPCOBbBo6D4dUok/vQc3pTWGMgByadigXEJFNX2EI6+X5ZT7LQZ1u4iWGELOmJeGtYeDv2s+l8EqesZSRxNzAOV8iQhphhNDv3s/AablO7DyT3j6snvsR/xptcCT2lRz+aipQ3nTAgPpyhgk11aaxKlcaLI9VgiiF5Hb3alQ9BJD5PK23hj9AU4euGtl6SPUzS8fIfD6cVvO7qupKxFik46cKtT7RUoeZn12Zs1QEDDuPbh+E0Q7uqwhlbKV16m2luWgIBz4eWm2TmU8PrvLWL+z1keZqwb/MeRV+pUfCZLVGZtXmwGN6Loxg5G0sKhk1B8wWnLS6ASwhhk3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=slGDFdxd; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=slGDFdxd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bskxy4gC8z30RK
	for <linux-aspeed@lists.ozlabs.org>; Thu, 31 Jul 2025 06:55:34 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7C9A0A54F02;
	Wed, 30 Jul 2025 20:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF61C4CEE3;
	Wed, 30 Jul 2025 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753908931;
	bh=cnyTzK3feprCwNlOU0zkPyf/P/0P8BcXQw0K55GzOBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=slGDFdxdi08cRmRyNENFkiSH1AYvRWEkK4vAlxRHLpYoEg3Yh2D6G2S43O/rSu1p/
	 u6bs728jC8qyfx30MGzhpwYtGRhzNY5A2wKFwRwXDQ80gvnqmHhNYXvJT3gK4MGPuE
	 Y23E+nc6AbLuAAcZnSCcGBWvtttw/JspjkFzSuI7JpIuvsBNTgqDh9RLY0hG1DtfUd
	 vpRRfUp8XSrjJtYxDYbnsIzUvuFXGVzszKV2AzjLO4mUaV2RXa+AsAEAZ/WAU07Nn2
	 0G4iw5bfIwXWrV6U8JSm9qPm5Ozo3FRLYq14pfZVOVZv+EvYleMYqJXh2xadDujcyg
	 STNa6kh+335Yg==
Date: Wed, 30 Jul 2025 15:55:30 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: rentao.bupt@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, Joel Stanley <joel@jms.id.au>,
	linux-aspeed@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andrew Lunn <andrew@lunn.ch>, Tao Ren <taoren@meta.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 09/13] dt-bindings: arm: aspeed: add Facebook
 Fuji-data64 board
Message-ID: <175390892978.1732171.6656964708595304137.robh@kernel.org>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-10-rentao.bupt@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728055618.61616-10-rentao.bupt@gmail.com>


On Sun, 27 Jul 2025 22:56:11 -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Document the new compatibles used on Meta/Facebook Fuji-data64 board.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
> Changes in v4:
>   - None.
> Changes in v3:
>   - None (the patch is introduced in v3).
> 
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


