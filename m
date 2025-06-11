Return-Path: <linux-aspeed+bounces-1384-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8AFC677C4
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 08:34:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHJqH4lNFz307V;
	Wed, 11 Jun 2025 18:34:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749630859;
	cv=none; b=MU0T0aIh0tj2gjk1IJT0GPxLdmLemq+1Ond/aVAEmQT/0oeigWygOIRHOKPWxCUJzYdWxNG6iZQE0vMCiiD0xnBQGSEYBz+l17+e0XTQtsghH39B7AMJK+l8saiHF/Qhlx6aLnr7Vm3VQFIwW7+n+09ZnMtCEJsKPBeoCZKgr52OZWaQalUP4Mh+RpupDAP0u/puXGxiWjSt6TFey070ey6AilsjoZ2eQFoUvAZB67q4z4pB8lQj52TJ3QMLRWIz1IJLV4yEkuTk0zm5igBFwSOJ6nTcukvRD4RAxU0rxfhjtC+9bh10uI3CpuC90tfaa44kZ9l3ZtwRUGstlci8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749630859; c=relaxed/relaxed;
	bh=sFubRqLaTRPPao3ADmJTjzXg7NYirox4Cx5yp8T1Po0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOU75DJQv5mCgItjFETEykQWdCE0A6h3Ycq+i1aAzkql0kqXfCJRPHuloaCHD4p52B4tk5gPX2+Ilu1s6hs/0vtjqdS104mAtvigw72vxKpuGWnMLlU83FE83alFatcH80882Z1kE3ag6V/vIemG4NRB1lIPTORkJX82cICe3mnL7knNeAlGvCw1Cv8EYrGaadHnLrmCdLwhX9wigPwKdgCqeGROsyw+kNvPUwlONUNwX/urXj132YxAlvkTkPSyAJiSYSgsvmMWMkz0/qCVyPJQFqcwoCqPU9h2Q46727ovosztqaiwj7b9xfEnNVRGg2YcEB1nMs6MjE0yJY1fuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Y3ULcI9I; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Y3ULcI9I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHJqG6K6Tz2xbX
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 18:34:18 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 38A64A51527;
	Wed, 11 Jun 2025 08:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5311AC4CEEE;
	Wed, 11 Jun 2025 08:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749630855;
	bh=YjUuaMXRjj3yUKM1oXzB5tryE1JdcUrQb6CsDD4lW7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y3ULcI9IJyU/3l5FNnF21dookZoXpT0aM6QPxdT5KR4dj5+MwmuBef05fRcY7CvZK
	 UeBU/WbML8g8V2ZL2h+sTSB8laoO7PDxiX6kvecKeUcl2IAD8GbCSkN9SavXl6WuY1
	 4MeUMVGBJiaY3jt32AJp0OJWQoVnQ6JEEdcJiQXz2RsWlMl+HyL8g3Otn+G0/gdz/e
	 eKJOq//e/kg3jeadV8QCPHBdmUKKIUSVGrkK1ULlLjfVMh6zbV28tPRlyVBMBK2u6V
	 L7MgsqJc0Pbe0lggsEFkW89fWPIeryKYmGkJTIrzKXP7Vk2hBiIfNccbDW/7SsIYEg
	 IaiTDLO+Cf+uQ==
Date: Wed, 11 Jun 2025 10:34:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
Message-ID: <20250611-serval-of-immortal-novelty-055c93@kuoka>
References: <20250610091026.49724-1-jammy_huang@aspeedtech.com>
 <20250610091026.49724-2-jammy_huang@aspeedtech.com>
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
In-Reply-To: <20250610091026.49724-2-jammy_huang@aspeedtech.com>

On Tue, Jun 10, 2025 at 05:10:25PM GMT, Jammy Huang wrote:
> Introduce the mailbox module for AST27XX series SoC, which is responsible
> for interchanging messages between asymmetric processors.
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  .../mailbox/aspeed,ast2700-mailbox.yaml       | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/aspeed,ast2700-mailbox.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

<form letter>
This is an automated instruction, just in case, because many review
tags are being ignored. If you know the process, just skip it entirely
(please do not feel offended by me posting it here - no bad intentions
intended, no patronizing, I just want to avoid wasted efforts). If you
do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here ('b4 trailers -u ...').
However, there's no need to repost patches *only* to add the tags. The
upstream maintainer will do that for tags received on the version they
apply.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/process/submitting-patches.rst#L591
</form letter>

Best regards,
Krzysztof


