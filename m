Return-Path: <linux-aspeed+bounces-1768-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7DFC83F1A
	for <linux-aspeed@archiver.kernel.org>; Mon, 21 Jul 2025 07:42:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blsn00kp3z2xHp;
	Mon, 21 Jul 2025 17:42:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753083748;
	cv=none; b=eA+EV4mc7B/2Ubos5HdDlTYgqG9a/5nyJCJAr0Fe7GidSrqmKqKTCQytre2m/1KOPRi8OVvkX3FUCgx5MCj91iQGISVVX2bHfOs+nUbiWPKcCWxZc765ugzq67eRVe2UgodsGHy+a9oPJe/T8pbugC0Xh4Zx1Oz0EAIcuvIpbAu4upJ1uHZtrMDdn7+SlEzQN6PuR82eV1IPHPTdFj3cqTqY+ncjnfHDcpK18HwAzbZMRl7li48rGwBTsPYVlVWMQLaRmOkvS+oLEOQ70YgtRz1DKCp1+SdJ+iXeRgzbOKtC5jWbMZYppQQ649bUuTkT5AIxPiSCjhSm/HNAueiyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753083748; c=relaxed/relaxed;
	bh=kY/qVqyukbmYuJU8aGt4dNrPbq/KEcARNTpYBPYTnzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwzw//QKwE2sQtBGd0hD3F6yuwYop92pv8fgOu/I4WB+jJZBnLJV1aHef/0tb7H/sJ/xd7rFK7h8eynXK7ADfL5pfNhHRfwUjugFs/ZzwEniWnb45BZ+8z0sIAeFiHuQtmkXFNI0vcxIyxuuYTM/q/ua2xK43qwozQLtuQCeZtNlIJ9O9mP02Bw71LRfsHgnEIwCdkPB/tC5oB9PQroDbrcV2TE57V7n93H/Muj4M//vxSYmIm5T6rLwdax0tB3X44wKeMauVFpKKF4LaKfVxODLT4rd3OU89su7ffTqCYrqIxHlJwMtYacLcwoJqIf67q3Ho1F5vAD77TKcGbUArA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rqw0Vu6c; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rqw0Vu6c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blsmz0ffBz2xCW
	for <linux-aspeed@lists.ozlabs.org>; Mon, 21 Jul 2025 17:42:27 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 86BC1601DE;
	Mon, 21 Jul 2025 07:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E87C4CEED;
	Mon, 21 Jul 2025 07:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753083744;
	bh=XYtXJcSx59acBjNpYrTcaOZ+McBebEu8GwQdfjrYlxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqw0Vu6cS5IaBiWbim5p6hULKDwdbtHJ26JLb4fSYufdL1D0VYixws+yPTzF8Fhne
	 eg6YXEPS6EnKMjn4OeT0TDyP7oCF7oqeGz9DcklGt5n36uc1mFN/f5NXo6ihTmacFl
	 zJlB5duUWRDI9Uohc6JfFlPqqpsLR2bw0qc8YJULxmJ/3O6IcaqlvsmJKDdhWcD9d9
	 Vhwtzfh9sU6u8oOaTG2rdUZQQdwTMeNIrkx2cbLktSVpHxrQclCbSzkTlWsGrtM1IR
	 DgUUI1dx065lxFQtYNnOIoWejKjCMuTfDhog7oC8XKb+Jyz3nGmcLmLA+pbJ4ZT6Lm
	 WXxj8IOMIXSLg==
Date: Mon, 21 Jul 2025 09:42:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Donald Shannon <donalds@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] Documentation: devicetree: Add binding for NVIDIA
 GB200-UT3.0b platform
Message-ID: <20250721-auspicious-uptight-parrot-b1e19f@kuoka>
References: <20250718231118.3330855-1-donalds@nvidia.com>
 <20250718231118.3330855-2-donalds@nvidia.com>
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
In-Reply-To: <20250718231118.3330855-2-donalds@nvidia.com>

On Fri, Jul 18, 2025 at 04:11:17PM -0700, Donald Shannon wrote:
> This is an Aspeed AST2600 based unit testing platform for GB200.
> UT3.0b is different than nvidia-gb200nvl-bmc due to networking topology
> differences, additional gpio expanders, and voltage regulator gating
> some devices.
> 
> Reference to Ast2600 SOC [1].
> Reference to Blackwell GB200NVL Platform [2].

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

A nit, subject: drop second/last, redundant "binding". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

With above two:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


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


