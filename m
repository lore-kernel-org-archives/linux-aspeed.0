Return-Path: <linux-aspeed+bounces-1861-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F81CC87FC9
	for <linux-aspeed@archiver.kernel.org>; Tue, 29 Jul 2025 23:40:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsBft6JGsz30WT;
	Wed, 30 Jul 2025 09:40:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753832438;
	cv=none; b=jTSkp6HtSwotzaVnERmKuA8nenPMrpPQFzvSf41qfmkltBYEEUdWGAFEbYegoNFRCxvtB8rIsD0cVl4jGDXUD6ZEI4b63OrtDtXCqK81pl9WdmTjMt3Sat1a4B8Vl1QFpSzyAo0Li+PFg+WfJLsSDdDgwe9Wq0d9p7nl5+1dIaYM0hT8qLxtShH2pGQcnZxpNDpSfbBb5LERfLsNB3O7UwFmHoEBFc//hAZo0Oga/4EwE0BaS3LuQ99k1+Pfuy0d/Vjh1jw3U87CY7yRz8deyIyf1qPxOKTVvNNzbL02tPzRQu95VTPkLKyZa6ByA/OGcK14YZsF/V/IpVO8bXJuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753832438; c=relaxed/relaxed;
	bh=KHqgFY+gayy2GZvTyvV7FSRSsazhmou5VtCdHkpvFGY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NQy85f0HzCC5VaFoaGJ3J9QVHn9jA9QMnnGO3E0do1m5ShfN7YwQDLqFdslfdkZ1Gf4rkatjJgchKPBhoIRETxionz4l/Rv+VY9gvKNxRvkwMkbPBKk1ay2upWMKGkEDZUVXlQrsVdit1uHa87V0PlhnmBq/Y6WmHdhOxqFKB4SVtKXLj9gM0aV8dBstFirjYGXAbS31HkKDzblKhikw2X9x6EAjPYG4YTpjNSBiluHBEzTHn7jyy7cg9OVBhGkQcdyIpGlf8iR+l748OQNNYPwdbGepVoIeshsVadYn5cqxuTN5AW949ssThLbjGWtBVQISeFpIdgziJmHL0IyuNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pUJn1kRf; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pUJn1kRf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bsBfs6jX7z2yKw
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Jul 2025 09:40:37 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1894D60008;
	Tue, 29 Jul 2025 23:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FC0C4CEF6;
	Tue, 29 Jul 2025 23:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753832434;
	bh=wyEt2fkgpUhHTrACpazhdhQaWVGoe9NGCw65Llk9rNA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=pUJn1kRfSR10kP/BkVHd3TvO+QCQMODJt9U6F5ONDV+SNQ7RSSrJwHhdFE0fT2p5g
	 BpcXDnJkXvLsX/+U9KuUqjKurQzqqrs4x81WaZxxB9ogLEphNaylOuXA1mFdjJZpSR
	 VIpO0HkHSDuA8FYdU9/ol0OVtXTSJXbRcY587YqkyS1Wcu+5Lh0PE6nOxcSjx/eCVA
	 l1jAVEwNocNnVdCdxW0mIBENV/JYWJV2sEi9Sn++FyZ9Yn6DFlXNm0i5m6uK/kBLjs
	 C+0fuj3tpbLFzVhDTBb8BH+EHS3/ocK9GujUpV8ae8L1wh2+li3p5prShi618b/ted
	 YxAQB4i+7n2LA==
Date: Tue, 29 Jul 2025 18:40:34 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>
To: Fred Chen <fredchen.openbmc@gmail.com>
In-Reply-To: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
References: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
Message-Id: <175383135828.1119152.922768974777985804.robh@kernel.org>
Subject: Re: [PATCH v1 0/3] Revise Meta Santabarbara devicetree


On Tue, 29 Jul 2025 17:13:42 +0800, Fred Chen wrote:
> Summary:
> Revise linux device tree entry related to Meta (Facebook) Santabarbara.
> - add sensor nodes for extension board
> - add mctp node for NIC
> - adjust LED configuration
> Base on branch for-next
> 
> Fred Chen (3):
>   ARM: dts: aspeed: santabarbara: add sensor support for extension
>     boards
>   ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
>   ARM: dts: aspeed: santabarbara: Adjust LED configuration
> 
>  .../aspeed-bmc-facebook-santabarbara.dts      | 840 +++++++++++++++++-
>  1 file changed, 839 insertions(+), 1 deletion(-)
> 
> --
> 2.49.0
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20250729 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250729091351.3964939-1-fredchen.openbmc@gmail.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dtb: mctp@10 (mctp-i2c-controller): 'label' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/net/mctp-i2c-controller.yaml#






