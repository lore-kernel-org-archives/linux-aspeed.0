Return-Path: <linux-aspeed+bounces-2284-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20361CA1013
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 23:01:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSWNF5n4pz2yys;
	Fri, 19 Sep 2025 09:01:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758236493;
	cv=none; b=kl9PSzSEczUWhl9qccK8GFKiKvc0QFhuxFvk+EetC5CWctMv22S8eONpqQog3WuBAIMGrXmi5o5Yq9xdPhhjJyZAXxS/K2fy2Fm3lSIJJibM2BIffdhWlHeLNvJiwVEEqm2B9VdGlYCGOFckNMVWQ/caWv7b6qRF0zZPS1tTZcaG2WA/KbvS3/ZBZg0Se3M3CXCb8eVAtZqgR1IEjiiyMg0/huHpUt9JCnOqAE78zCzZSx+2M25sMJ7DLWOjEFSm7w9VP8zs6Hielhc5YGbfwAxrZsbe4lcmsjtn+5NZZRfRhB/tomwRkJAwkGi0QSuRANrbbDav8nzshEmuwpqYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758236493; c=relaxed/relaxed;
	bh=lq4gOLR3WzjLFfYqCgB1bKbiq+M0YIO3yw7pfSzsv1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfIA5X7I5mDRp9WNRUAv+c6bnEOvMInYKuKXv6orpgiWnFUbYyofkXj3H2N77IQ5JsmpLmmRlVNyLuqSlCKNa9FAgoI+N3XBGbwdLwrjSF6eQ3E6geP8Ydz/pv0UrusI01LXN6NZjBvzns7Jh4RStZtj6+q4KuNlalYIs7/s6yovrpnkSrZaQk0xqMG45+cOG0OzvAfYbH7RmLPLmtz03nYFWwA1BhksXu6oqqcNbmXRTuEINShoor1wWzgncmwwm3UbzIzsRQRI4OamEn7mdXGuMbBoywdDGfABjcFxnWplIJga3/7vzODdsgqb809yRXtODp8t/vWZnq1xqFCpMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RdHegd7N; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RdHegd7N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSWNF0Zrdz2yD5
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Sep 2025 09:01:33 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 90AB943370;
	Thu, 18 Sep 2025 23:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137E9C4CEE7;
	Thu, 18 Sep 2025 23:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758236490;
	bh=B0+XCm8kbd8Xs2HVIhSFMmC3dHvcsySFO4FzYVBuKx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdHegd7NYUEdaDKA/IAV3luvVhd1lZNKbzVdFXscTQshx7QyQO7r8qrrCHvB0NtuN
	 BSAqawfIzajqbPc26CDZeizT8YwN9XT6uwkfFi3REKOOO88s2JHeJe/W6tlGXr6PNU
	 C43OY9sm7brrg8ndAMjxL+v6iN81WRgiYOZ1mOr3nUaNCyz/ey8BG0V2Hpot/PdiyR
	 tCnZKJw9CtaasaG+VJ4N/DXSknCv3IakhGEQDzEYtkK5E/xZb0zK6EqBxlzwPraGCr
	 PomhSpXB2am+Xu8wDAjfLh/2Nmh/is3eulj7dfbguqa08rYz0F5sk6A2E3V5GoR9ce
	 lhUfqc/4nR/uw==
Date: Thu, 18 Sep 2025 18:01:29 -0500
From: Rob Herring <robh@kernel.org>
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
	andrew@codeconstruct.com.au, conor+dt@kernel.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH v6 5/7] dt-bindings: hwmon: max31790: Document address
 and size cells
Message-ID: <20250918230129.GB3127900-robh@kernel.org>
References: <20250918180402.199373-1-eajames@linux.ibm.com>
 <20250918180402.199373-6-eajames@linux.ibm.com>
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
In-Reply-To: <20250918180402.199373-6-eajames@linux.ibm.com>

On Thu, Sep 18, 2025 at 01:04:00PM -0500, Eddie James wrote:
> Since fan properties can include reg, the fan controller should be
> able to specify address-cells and size-cells properties.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
> index b2dc813b1ab44..42e7030360f1c 100644
> --- a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
> @@ -35,6 +35,12 @@ properties:
>    resets:
>      maxItems: 1
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +

As I explained, this is wrong if the child nodes don't have an address 
and are named "fan-[0-9]" which they are.

>    "#pwm-cells":
>      const: 1
>  
> -- 
> 2.51.0
> 

