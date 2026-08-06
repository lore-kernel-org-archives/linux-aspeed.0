Return-Path: <linux-aspeed+bounces-4642-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84454C56208
	for <linux-aspeed@archiver.kernel.org>; Thu,  6 Aug 2026 13:31:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hG7Tj3lBcz306S;
	Thu, 06 Aug 2026 23:31:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786023081;
	cv=none; b=maWSebPC+Z5aZ+sM7QqvoUsv5bqcjOo6a4uVu8j7aYGeXKbscXPEkiK0eT8zeN2WhO3gkKG86jk3gFB04Wl38eUbCUb37Yx5Bh/82LufzUB3hDNbTnwvsgPjvk7tSOd+zVxn9aL9yz/aBEmQyqEtuYTuKqwBrpmeGq/i009BJRFmjif4xnuQAep6+X3Pivb/CAUP6oSqPPhAKhUV+yv4knQ2xKscH0mB54jXjK0Wf6CyujqioUEkkEcQXkAsNajdI2+CfsA9NxZP0xt7jbiqSZ20R+Fib/C6wPBM7e8/d+YodzD8P1t5UBjDq19KSUIu5iMj4H5DEy0kvOYKnJQQcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786023081; c=relaxed/relaxed;
	bh=Y0AD+yfRRB8kFuS3umG0hhMkgfqhZmRwgX2ATJd2Akg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXvpadgJuJFNEyJNNXLIVv7iGG4rivBHAOFPesx0P9DLCzMUTLrHlHvgLwm1fwBv/SqdH1h5iGZJtGBjxyCVEFnULxu71F18JSZq85MXlHRRUy3c29p9e54GHLWtbyDmsdkt654aJJXd7CyzLIxdZEHlOb1IjtpJAr1I5fqSUcfVkuW5md03Ngw7mRGML/etW+a/a7hzMaiNWab8jxfyQDB49W5aXnqw+VNWRIfHoyMBuXbZNwUyA5hxxLUD16r5inGku0HVLAkRuT/bsMZRtzZeqPRMR80cyyOHP26tlw9VA/DMdESMMmHm2sh5rMn5QZPwhOAq0bgNky9Bd+NzpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJTV5eho; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJTV5eho;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hG7Th2w85z3054
	for <linux-aspeed@lists.ozlabs.org>; Thu, 06 Aug 2026 23:31:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4FF3860A5C;
	Thu,  6 Aug 2026 13:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1DA1F000E9;
	Thu,  6 Aug 2026 13:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023077;
	bh=Y0AD+yfRRB8kFuS3umG0hhMkgfqhZmRwgX2ATJd2Akg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hJTV5ehoIEF8y7Kgco+X0NK8DYm3FHIb5dwVRUwRJ+mDkIY67nsnTkvehjQzkyyOE
	 +lU0FGL1ltpTL5CrMMW5U/tDWHoyh6M2NA48HP662X36/fOLJ4+d5+Q4aq3USy6AxH
	 jr/gGrVQkNanDlcErJfMkiKmeNFK0mBr4gAbfG2WrInh7LbSdlW8JhZtT4oAZGVHPv
	 SmNcAUbJTJ/7JUHNGXIIhiPOzEkoGNYMl0YB+1AFQREPucGLLpdar0eSPnma2ZuwdJ
	 txnNntcMTSk6DP5HprY8bQtNAHroh8k6MbILqDlN8MN6TBWGUpLBWQkQ4RRVsA/sb1
	 rildWmczV4maA==
Date: Thu, 6 Aug 2026 14:31:11 +0100
From: Lee Jones <lee@kernel.org>
To: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
	Corey Minyard <corey@minyard.net>, Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH RFC 1/2] dt-bindings: mfd: aspeed-lpc: Document lpcN
 alias for multi-instance SoCs
Message-ID: <20260806133111.GF2869284@google.com>
References: <20260723-upstream_kcs_multiple_lpc-v1-0-d918b5270b86@aspeedtech.com>
 <20260723-upstream_kcs_multiple_lpc-v1-1-d918b5270b86@aspeedtech.com>
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
In-Reply-To: <20260723-upstream_kcs_multiple_lpc-v1-1-d918b5270b86@aspeedtech.com>

On Thu, 23 Jul 2026, Yu-Che Hsieh wrote:

> Some SoCs (e.g. AST2700) expose more than one physical LPC controller
> instance. Downstream devices such as KCS channels need a stable,
> globally-unique index derived from which LPC controller instance they
> belong to, so document the "lpcN" alias convention on the LPC
> controller node that lets DT authors assign a fixed index per
> instance, mirroring the existing alias-based numbering convention used
> by mmc/i2c/spi/serial.
> 
> Signed-off-by: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>

Why is this RFC?  What's stopping me from applying this now?

> ---
>  Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> index cbc3a2485a2f..81c12e0fb312 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> @@ -35,6 +35,13 @@ description:
>    configuration, therefore the host portion of the controller is exposed as a
>    syscon as a means to arbitrate access.
>  
> +  On SoCs that expose more than one LPC controller instance, it is possible to
> +  assign a fixed index to a given instance (and thus to downstream devices
> +  such as KCS channels that must be uniquely identified system-wide) by
> +  defining an "lpcN" alias for it in the /aliases device tree node. If no such
> +  alias is present, the SoC is treated as having a single LPC controller
> +  instance.
> +
>  properties:
>    compatible:
>      items:
> 
> -- 
> 2.34.1
> 

-- 
Lee Jones

