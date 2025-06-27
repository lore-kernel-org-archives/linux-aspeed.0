Return-Path: <linux-aspeed+bounces-1586-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4860C7EE31
	for <linux-aspeed@archiver.kernel.org>; Fri, 27 Jun 2025 07:00:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bT5zn6hk8z3069;
	Fri, 27 Jun 2025 17:00:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751007637;
	cv=none; b=V55K3dnou5A1RkzxElv0WNrEAEMtuE0Y1cBDX3H2leVrqYgvwMAGiVW1U4WhRx3heVb7xV1FBgvr6FlSLjIRaVjdC9KkZCDlBxEF1AZJHNGGFhnWoh5eGIxZqiPfZCPfgfsIgmzN3UrZCGlHjI/+jZUW1vOERpZVDSUBwIYtQZPk6A/8U78FO+c5Dp8QTQPu1oxGDntK4xeEza2XtpDfDd02VlO7v5iY/WoXCaHEK6C/D3sN3bNiLloZr/6a5L1EB0MO/fsdDwUulHtvky6uyR+rLuXIGp+GEHeJWv9ETK3y69Ivi3fi1vVeF2smcrYbM/aANBMTyE5L2x4wfOkNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751007637; c=relaxed/relaxed;
	bh=fVPaUJqCY8ceVuswXPqSPTKh9rTcLJj6phtzFkBlZj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmPE6ZYmtu+VqytpfW7tsbAyDv7a5u2FMkvFX3mpkdtg/4nu7vk+O3Z1ysIWtrC766ZfSSNDdGCgI2OHGi1o/DsJhZo9fPrLrWzfaGDd8JqhnNdY0iPWBi7vDuRPVg9OSq7aMpHT7pP0Mz5XeiwtMPZN7NJulPODCOXHlVfgVrxq70X+sSpYp2gJWCWjRnaZ53VCaP8jx/b979g3U8rm5LGQEb7t/43PeIvvFKDNJ1m1CYMUFxOjxbjrcBuI9Mdn1Xqc/RKDCW5Eq6VhIWgs6dP3SjFeyrU1lyj6LVgVwkkoC6JeXx59Is40518JiNVjl8LGGb7auYyqnMqeJpoQwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qPlmnBFl; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qPlmnBFl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bT5zm4Xwlz2xsW
	for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Jun 2025 17:00:36 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0AF09A521EB;
	Fri, 27 Jun 2025 07:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4F5C4CEE3;
	Fri, 27 Jun 2025 07:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751007633;
	bh=2Uk6mPLluwOGTpyaSNA8mE4z75MK59plAzgVuBSAIJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPlmnBFlKtkL68K7UTMLDKSF2L3+BrpBxHEC/wc2OKDzTpGBqVXnSnK/TfYEHNsFL
	 ovV7Jj2Me76edKk5EVcbp3YdUDhKxrmksObBMW6m+w8sFWO62FkHxQA6QCXHrtWEhY
	 FR0CQZgCyzgMYXzjnhhuGoc3XsnRjwYZIna9+GDzLtmc13KExsjUldUTh4I4XXV/6d
	 8kUfvWRCv8HpCh0xjXMEs+MqikvpEr58IavaEPEctgOexAckVTsfV0tUERIte3t4IV
	 ZGK6AygZqDueGEwAJ0bZsxTqs3LG9RenKfWXKj13vL5haKXqAMI7RDrODv9ob70UpH
	 rhQM+nWdK1M4Q==
Date: Fri, 27 Jun 2025 09:00:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Leo Wang <leo.jt.wang@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, bruce.jy.hung@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
	Leo Wang <leo.jt.wang@fii-foxconn.com>
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: clemente: add Meta Clemente BMC
Message-ID: <20250627-banana-falcon-of-jest-c0a8ec@krzk-bin>
References: <20250627-add-support-for-meta-clemente-bmc-v4-0-ce7ff23460c4@fii-foxconn.com>
 <20250627-add-support-for-meta-clemente-bmc-v4-2-ce7ff23460c4@fii-foxconn.com>
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
In-Reply-To: <20250627-add-support-for-meta-clemente-bmc-v4-2-ce7ff23460c4@fii-foxconn.com>

On Fri, Jun 27, 2025 at 10:59:03AM +0800, Leo Wang wrote:
> From: Leo Wang <leo.jt.wang@gmail.com>
> 
> Add linux device tree entry for Meta Clemente compute-tray
> BMC using AST2600 SoC.
> 
> Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>

Here as well

Best regards,
Krzysztof


