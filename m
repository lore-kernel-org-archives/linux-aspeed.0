Return-Path: <linux-aspeed+bounces-4742-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34D5C5B572
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Aug 2026 07:17:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNkfr0hlsz2y1Y;
	Mon, 17 Aug 2026 17:17:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786951028;
	cv=none; b=mf5sC0/+5J3g9Bny4A/g+K3JsmflEXZSVc+tMYqlJVhPzlk6oI75J73ICFsu7ZNDA9OQISS4p+Y7dINy70wqwmio8dhaIKex4QUauZBY7dymYxtqv5Z81t1BwIH7hkO9V/e9rae+asfTqm0h4kNq72zKN5w3ITw6Rz8EMboR9mUtR2Q7iMUY4PTuQ4AAop4AWafpqPxBmdAGTi/mWZVXm/D5d8ks77+UO4wXj/nhKe8vVaYSaLD5m/MW5Fm72qV/U/5KG0eMMWLNDnvGVwSQaCHOmFKiADiClwqr32Pk4r/kkdlu5UsIcZIyRTYNNeuMmvTG/q5KjWALi2iwFZNtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786951028; c=relaxed/relaxed;
	bh=nHaiYM/y/snjrD+pBdi2eiWOhp1MMx3lZzj8PlHwRPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aC28UlA+3RmhLR5JuUXcmPpQF/20J6hoE0ZWpn96pjhSfGOGzYK8JW0az3X5svqGVEylbH2yla/C6466zrD5CHaDahDPCf1YX/1tDm0Dd640FiiLBSEscy2juv9HgkublMY4GdkbbNNnRv2E1JkSSJ2fhTIHAZuIg9ZJKpvDsQOH34wtEBwKkZctaHKhxYTxAyA1Ccdp/SWOZ7kdejBKjRNVk8BqFYTTdeEXUbeDNRgctw3CwAEyxZ9FptiqTO3/WelArpF5LccZn26fKgF3N99KH7Y1QURC2i4Tnkc/1ys49S1AOwnT4T1X+/ZL/nrVxT3xkdH+/3988aBvyVsc3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcPIl2uh; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcPIl2uh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNkfq35X6z2xy6
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Aug 2026 17:17:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6CB4D601E0;
	Mon, 17 Aug 2026 07:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E6B1F000E9;
	Mon, 17 Aug 2026 07:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786951025;
	bh=nHaiYM/y/snjrD+pBdi2eiWOhp1MMx3lZzj8PlHwRPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dcPIl2uhgtsnkT79J9hFbkIy7Mwr63n7Und+fNsaJpQpPcO/OnUn/GA64X6FzwknS
	 r0TubGF/Wi7V1cB/Q7S0glps0hlBdTd08JwkZ3tLgZ7LQuMbqf+IP5Xh92wfROU3Xc
	 cKTOxuuT7MEns7rO3QJ1H0xtOQJjoq/H5QFZb9v91YqX7q8xVUvHX7IQDD6s9UkzHs
	 2kMzCcR2EfN/sJQXl4shY/+mMRbt7IfpDsm2e23eJzOaadhzzgzK5OnGP/LjsdDZl7
	 hGaOUkxr5o4tyeirOAeBw++yZc7k/E7d2uNeejBlaHCuHIjm5nmP8C+lMKEzjEu2dx
	 pHHxhlLvbxHmQ==
Date: Mon, 17 Aug 2026 09:16:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Corey Minyard <corey@minyard.net>, 
	Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, jammy_huang@aspeedtech.com
Subject: Re: [PATCH v2 2/2] ipmi: kcs_bmc_aspeed: Support multiple LPC
 controller instances
Message-ID: <20260817-hissing-beaver-of-potency-994d0f@quoll>
References: <20260813-upstream_kcs_multiple_lpc-v2-0-775b1db3fe95@aspeedtech.com>
 <20260813-upstream_kcs_multiple_lpc-v2-2-775b1db3fe95@aspeedtech.com>
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
In-Reply-To: <20260813-upstream_kcs_multiple_lpc-v2-2-775b1db3fe95@aspeedtech.com>

On Thu, Aug 13, 2026 at 02:42:32PM +0800, Yu-Che Hsieh wrote:
> @@ -526,6 +528,17 @@ static int aspeed_kcs_of_get_channel(struct platform_device *pdev)
>  	return -EINVAL;
>  }
>  
> +static int aspeed_kcs_of_get_bank(struct device_node *lpc_np)
> +{
> +	int id;
> +
> +	id = of_alias_get_id(lpc_np, "lpc");

NAK

You do not get custom aliases.

Best regards,
Krzysztof


