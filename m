Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FDE606A320
	for <linux-aspeed@archiver.kernel.org>; Wed, 21 Oct 2026 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4DMs8kV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8yq351ZVz2xSD;
	Thu, 22 Oct 2026 05:43:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792608223;
	cv=none; b=Zj2/Nd5G+R3+ZhjKm2v8A5YNXnn7tfPjIP2AbQL2XUqPSavzkO+NpvJZIgupR8jqKRPrpbgXDhhqbY62mAW024jk5ep3FeCNL+BDVVi0GAEho5psIoxL6pzMIz6thZe8r8PE3HO80+qXHoB+JB3Oi4bbk6XYJ2LLHXvTAObZm4I9QDOWCvSxfSfTggCZSi+Kmew20Tq1mR9Hym/2qHaJ1Ds9lqcg6bpnO9N2R9buHULEnv2/KaH8b1el/lwv0tmsfE6blddm+8nWecTqZPtZrThuvN+Yv7YgzjigXWdLFX9SgzZpzsWXh+HEKBAuJFmOIagbgRmE8v01ZbKbpTCClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792608223; c=relaxed/relaxed;
	bh=Yaa6k5Fi/S8yLcSO8oA5OP0KYAzuBkSJifuZS+OJQwg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXIX43w34b1pqsnnukP/xG5MPzCrxgtIR4GM4UFwp14ORop8xv1gWmckT0h5g8HPcQrEnWZPmxFqppdIbn7jbDk3TVRHjX0dpT6uM2+rt9/LzinHGXbrxmkCRTOPUJtTRfd/ejpfgDnUeY/vwWfRENpiAyBNi4dOp12/J/KsPoKstMS54OPdEbteEbbG1LClKXBly2eDegNDZEuHQ6I2klG0Urr1955zXZldNbXknFKSxHPCDlAGJfbxdoWKeJGpz1CEvSR9Yd2n/U4FS20yewlEMxtyR1/PDK780GxcU0jQa3wdmioC/3g8iWvP6VNCtUxvKeIw85aXA/avCWsXlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4DMs8kV; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q4DMs8kV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8yq25xSVz2xPW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 22 Oct 2026 05:43:42 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CFDBF60052;
	Wed, 21 Oct 2026 18:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39751F000C1;
	Wed, 21 Oct 2026 18:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792608220;
	bh=Yaa6k5Fi/S8yLcSO8oA5OP0KYAzuBkSJifuZS+OJQwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q4DMs8kVxPGEaN7Axg9dakbNTgBP2NukZGUkfwdkGiJd2vewncfX2IL/BP4IW9GQd
	 8HRndU+baQEdiRdKBKFYuHOehHyfenkrIscmvzQk86iUTA/NESFOO3lF2GZmxcHgJK
	 /iY1tW+Bd4g8AwVRtyB5iI9JaSNPAaEOPvVmO//Hbc65Bo2QNSSrULzY1Ba0wt+zkS
	 ItAmKgvV84ZNMX1S/lpls36R9WBNW7mkvuQq6hHTgZ6YvYEm1hVNaG9OMD6E9xlN8Y
	 V4+qzZhzn/zKRVX4zPRD/bt7qwmcT6IRDwFuL6Nrjbu5v5F1GbRmJTNTZ0a/vBm89z
	 kvR2Ya+aXNHZw==
Date: Wed, 21 Oct 2026 19:43:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Arnd Bergmann <arnd@arndb.de>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4] arm64: dts: aspeed: Add syscon phandle to AST2700
 ADC nodes
Message-ID: <20261021194334.587dbe77@jic23-hlaptop>
In-Reply-To: <20261021-ast27xx-adc-dts-syscon-v4-1-4fab164f10b4@aspeedtech.com>
References: <20261021-ast27xx-adc-dts-syscon-v4-1-4fab164f10b4@aspeedtech.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 10:09:39 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Point the ADC nodes at their own syscon1 so the driver can correctly
> locate the reference-voltage trimming data on AST2700, where syscon0
> and syscon1 share the same device-tree node name and would otherwise
> resolve to the wrong SCU.
> 
> Fixes: e77bb5dc5759 ("arm64: dts: aspeed: Add initial AST27xx SoC device tree")
> Assisted-by: LLM
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
> This was patch 3/3 of "iio: adc: aspeed: Fix SCU lookup for multi-SCU
> AST2700" (https://lore.kernel.org/r/20261005-ast27xx-adc-upstream-v3-0-ef25552d3a59@aspeedtech.com).
> Jonathan has applied patches 1 and 2 to the testing branch of iio.git;
> this resends patch 3 on its own, now with a Fixes tag, since the
> driver falls back to the old global syscon lookup whenever this
> property is absent, so patches 1 and 2 alone don't change AST2700's
> behaviour without it.

I've now moved these at Billy's request to the fixes-togreg branch
and tagged them for stable. That will go upstream sometime after
rc1 (rather than waiting for the next cycle as testing would have
done).

Thanks,

Jonathan

> ---
>  arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
> index bc990f79e693..053673cc4b8e 100644
> --- a/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
> +++ b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi
> @@ -246,6 +246,7 @@ adc0: adc@14c00000 {
>  		clocks = <&syscon1 SCU1_CLK_AHB>;
>  		resets = <&syscon1 SCU1_RESET_ADC>;
>  		interrupts-extended = <&intc1 80>;
> +		aspeed,trim-syscon = <&syscon1>;
>  		#io-channel-cells = <1>;
>  		status = "disabled";
>  	};
> @@ -256,6 +257,7 @@ adc1: adc@14c00100 {
>  		clocks = <&syscon1 SCU1_CLK_AHB>;
>  		resets = <&syscon1 SCU1_RESET_ADC>;
>  		interrupts-extended = <&intc1 80>;
> +		aspeed,trim-syscon = <&syscon1>;
>  		#io-channel-cells = <1>;
>  		status = "disabled";
>  	};
> 
> ---
> base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
> change-id: 20261021-ast27xx-adc-dts-syscon-9cf5d733ed0e
> 
> Best regards,


