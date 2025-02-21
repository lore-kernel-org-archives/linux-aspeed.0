Return-Path: <linux-aspeed+bounces-803-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB02FC021B3
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Feb 2025 08:53:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YzkSC3XTyz2yVD;
	Fri, 21 Feb 2025 19:53:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740128011;
	cv=none; b=YGaDxigf7Wolnql4Lc02o52KTEyB9fXLV32rdVz/CA1H892aHG2ODeb1O/D4UMP+VCnE7TRFMfMdrMVWkssHjVe7n4F6l/Mdlsc8p+grMjso/RA8x6h5UDpM/xzgugn4C6Q60CVaGsraY/HGTMerMjpjzvdnWYwZPs99sChGKu3FXGKrMoKDghgAUza5NqqhW5p4awZtX/w4ZWa6ha7Qvc5hpD6VVd2FhHBGEkPxEv/frKs0Z3lst5detzfC1nKDo1VLplmy9nYQjDi+IK98/d99fAMo30LAE+eSfCSVr61vnGgHJSkb7fHANXIOsR+BQdKiaq2Arkz4YvFSuXm9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740128011; c=relaxed/relaxed;
	bh=fcJjlpeyXzb2MzHFKcvtwBz/4bf3EJXGWHvW2DoudH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di7ujEm+KSdOqz4AzHk/kGp8FTOMKlTSKKI7P7Ay2R+pE/I9fsBbgk3GLGvYFHEtqCX0TIBHBtDCVdY6wGwde5syZ5fNQQYor+9vEcKhuSgF7UpFDLti36A5jHEUlwHn4Arvg4UiHUMlAIOKlvE2YqH8BemyciMrVY5R1mHlh2CcnqzMVhxpUyJPWCqzG6AoosRE8IJW2UVL927JsvGGQ8FLo8cV3XNcZeI5PlidJU/iGeNN/n42imUzGATg9zUdCCHbk4zFd+4OWH5QwNcopmIHxBkLdpz+Ttw38JMzESJz3GCmX6R2/26LL2yYNSVBO7IeCwvK30ZdBoRsggOivg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jelLMFNa; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jelLMFNa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YzkSB4Jq1z2xfR
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Feb 2025 19:53:30 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 65FD55C4BD6;
	Fri, 21 Feb 2025 08:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86E0C4CED6;
	Fri, 21 Feb 2025 08:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740128007;
	bh=ufq+kuK2QPpM9XRYBH5cQn88jzhhfzY0KIE8Rzn3xX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jelLMFNawHIat9A4axKk0DaD9fj0A5irPaULDIOlSnl86np4L7NbKsDViDughdkFe
	 /jUKKAkNBMjgppVRACdScUngAFrr8XAjJcpD5ib+2wWRJg1Zh+MfztwRJjMkniCUhc
	 MGhgX5Lt8xDdm49JVFojPYFtkk/jzsyMnTKpmCnGUTHl4XyODIyr0xzsM4NqhXZYTV
	 YKX52fKnqJz32QC8NovJbq5DU6Wpl/nvYjWMUMu9DU/bv8qF8Q8X44LkhRLn56tfty
	 blOEBSxtK42HLkFIjwULmDHm2wQ+FedVQ5ErwIw7AdcmPZMU9awAl4RCfvT3nXzEsS
	 3khLWcex6CdFg==
Date: Fri, 21 Feb 2025 09:53:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrew@codeconstruct.com.au, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: hwmon: ucd90320: Add additional
 compatible strings
Message-ID: <20250221-determined-prophetic-perch-a8cad4@krzk-bin>
References: <20250220205948.1777200-1-eajames@linux.ibm.com>
 <20250220205948.1777200-3-eajames@linux.ibm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220205948.1777200-3-eajames@linux.ibm.com>

On Thu, Feb 20, 2025 at 02:59:47PM -0600, Eddie James wrote:
> The device driver for the UCD90XXX chips supports several more chips
> than just the 90320, so document them.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v1:
>  - Add all supported devices
> 
>  .../devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml        | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
> index e8feee38c76c8..3cfcbf6b58f2e 100644
> --- a/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
> @@ -23,7 +23,13 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - ti,ucd90000
> +      - ti,ucd90120
> +      - ti,ucd90124
> +      - ti,ucd90160
>        - ti,ucd90320
> +      - ti,ucd90910
> +      - ti,ucd9090

Last two have mismatched order. What's interesting, driver has it
correct.

With order fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


