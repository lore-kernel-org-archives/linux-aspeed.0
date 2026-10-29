Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B0606A322
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RzkRbN1A
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFfdR4hn2z30NF;
	Thu, 29 Oct 2026 20:51:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793267499;
	cv=none; b=BEOocIrWtwpQCzfk1XkFMz447EUFOmAXPiE8WqrOmZs3/2yqdN69YtDOlj/YGIOSr9HE8z1Tx8zcZuX2mge1N5qTbt/OhkBA+CrJbLk5QvFu62+BiuPd1MQMMbe/upPCoRt11+v4wnD9DkjgxmFDoYgh6/AEH03/8oBBtiAorK6tvQbd8U4nERQE7rr+A4BaQhwZjQOlt4bA1WGBwog+l6N6soINE2s3AkgKgXbfP0JHAHE5239gB8bq68z2IqUalMXcXXceAhUP0/LyPYQpvlYogok8myV8pAM09CzcCHsrM3Tvzf9yDoNMBl/et1psjqRvUnGNfTlj8EJ8ygwnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793267499; c=relaxed/relaxed;
	bh=ZrDU5unb+/T4yF2u2+zJeMQA2Fa/YM0sDkOzIuNIOD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRWyoHKZSS7Nc4HyxRE6hXAVUIO+qNO44V5e9zeX+ANmqkKv5iDsAGd5cbus0V1/7xlBvPEiPDt/2SjN7l1yECx4eJADtPmOSHosxowWDZkXWmisXpwVi131Cy3g4whASRg1WDIzl9rShNQGw8aGCY2qhlNJ1Fh2HSgzgB+PZ0JU5xcIM1t5OihyntnUlObBGgMHr5eGvuj8ZFIqrLtP1RnoYkniuOrZQjQ8afTfQJ8XnDfGw9/qpHssiqNI2SMMUuzoJvpWTN/vpuT4OfFKzrdw70gWtSw7lI+waIweKMuVpFa4diel1QJNsuMpOUSmuof1jiVCQ0V1ZyPvcvQRDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RzkRbN1A; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RzkRbN1A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFfdQ39Ldz308H;
	Thu, 29 Oct 2026 20:51:38 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 81115600D1;
	Thu, 29 Oct 2026 09:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E2F1F01825;
	Thu, 29 Oct 2026 09:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793267495;
	bh=ZrDU5unb+/T4yF2u2+zJeMQA2Fa/YM0sDkOzIuNIOD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RzkRbN1AQOWsju/INxyeR8LepG3KPjEBLYl3lBkWKEx2Bj68VKmlGk9BCrLscuSw/
	 IXQyyN/JH/ysxLkEeJKrjl2b3M6Z5jbKI/4tRexgXL4sdjiydl4sy6G7Pf/TB24IEs
	 P+rCGFvW1hhELvxhX8T+eNzmW8EJmtzzp7HBzq8ZfQ4XEfsXxoV+UgDQnEci+qIb7q
	 mCRlBaUGKyCHIFIDk60BuuYk5kL9IMO8VFmsR1AdBoOHAeYBY+810O0KsCg6mo6zAO
	 gt/9T2+K9UEoUKfiqPaipA7YVCqNR+ct37oXxxpnaDAwPv14cnuIKkzKzlI5unzeT6
	 e7sWNVgI0Hbjg==
Date: Thu, 29 Oct 2026 10:51:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Huang <jackyhuang@nvidia.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: Add NVIDIA MGX Vera C2 BMC
Message-ID: <20261029-camouflaged-enchanted-mushroom-d447ef@quoll>
References: <cover.1793243187.git.jackyhuang@nvidia.com>
 <ed348a94c9432eeea53f50448a61d93f99de7821.1793243187.git.jackyhuang@nvidia.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed348a94c9432eeea53f50448a61d93f99de7821.1793243187.git.jackyhuang@nvidia.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 01:58:07PM +0900, Jacky Huang wrote:
> Add the board compatible for the NVIDIA MGX Vera C2 BMC, which is
> based on the ASPEED AST2600 SoC.
> 
> Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


