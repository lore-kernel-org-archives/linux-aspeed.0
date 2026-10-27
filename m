Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4B6606A32A
	for <linux-aspeed@archiver.kernel.org>; Tue, 27 Oct 2026 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aj/lYZAN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDQNm2jYfz2yTH;
	Tue, 27 Oct 2026 20:36:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793093784;
	cv=none; b=mucCUuTvKfTjDOjCbHcIlJ+TvkprfLhwEJsnsFwTUTCBkP4VQ/hK84YUg1MF/khNZhM/yebil8FADXAIJ+k6LqroNMO8tA4Z/GP6LQLEzEHgibCV7KftJLk51Hp59f0Onb3ffWL0V5z1FPA3kmnSCXULwUszXEGVcmMjhPLx42Gkt/40G6TvPZI2hUcMIc/yPtaYf9LpZGXZtAU1nC8WPV2oSZg89RL2060UKmhw1vdwPfEp0w/0vjU23aW1S7q/kdF6klZUDIE9s+CN7VcdSyCA3H7LlNCDsRAxShWHx7BAEHcmtOIGO5KR3VP1ofi/jWS/unh6MUrDKrP4Cz7D/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793093784; c=relaxed/relaxed;
	bh=Dplzi2jZF0nyquCM7rHIi1KSd7Abrm4kSHyoRVVxXRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZY8YJYyZ0ijCXFwW5JjEHOFVdg3H72xGoEutkNPykhmm+0JHYLelRUppnbaepJFtJafURGfgSV5m7n2dmt831K2/4el0uDkQYQKvHOFWwBHWCFMMewOYQJg9lxWCtxRQgmUGpNIU+CdhUM0Hn0MX7iH3UoVgSCU18FU1eoW2K2Js/NzQKHQVxq31Uing6qB7JF5PYfTZqnRgdsg53JOFvfgDFcMgAaOQRT6R3REA/Jp6PGlqGM6E8bOZsdxnrvudP/PJn5Ktgh24ViB58nto30zwmvFsIdmO8FUislVXLEdkB31zqWlrp12JaAWCNWuUThqSPWO3WsmLXsrgBKieA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aj/lYZAN; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aj/lYZAN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDQNk6pbWz2ySk;
	Tue, 27 Oct 2026 20:36:22 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C946E601F9;
	Tue, 27 Oct 2026 09:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539271F01825;
	Tue, 27 Oct 2026 09:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793093779;
	bh=Dplzi2jZF0nyquCM7rHIi1KSd7Abrm4kSHyoRVVxXRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Aj/lYZAN94E+6oT9IogJZDY05+cE2hW1lTqN2T63l9yDpAGpWcsfyg1/t3Mup8w30
	 wJjK3nV1p6T1ggPDeD/x5scfRxApF9EkOpoFvra2dF1dLjxxEvI4+iQjc/xtIbu+dr
	 5kPrz9bMduX6FgzsCDjVqlOXmucjsI92g8Ehw5Z9jJKVA6sDxbkBQj5STdbeoMp7qt
	 2caDa5n3rjWAjXs0iIlQmsdE4PISikdcKPzWaAk2MThAmkzgeALKqWVro8pFRGh8Qt
	 ZkbmWMND8JyQKudyxAK2deV7K7NfXYveO387oxAbggPHn1s+t7c5nUHzlWrZXUzADs
	 hBTXght82atfA==
Date: Tue, 27 Oct 2026 10:36:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, ryan_chen@aspeedtech.com, 
	billy_tsai@aspeedtech.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
	andrew@lunn.ch
Subject: Re: [PATCH v9 1/2] dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
Message-ID: <20261027-savvy-powerful-seahorse-cc1079@quoll>
References: <20261027034911.99482-1-prasanth.padarthi10@gmail.com>
 <20261027034911.99482-2-prasanth.padarthi10@gmail.com>
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
In-Reply-To: <20261027034911.99482-2-prasanth.padarthi10@gmail.com>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 09:19:10AM +0530, Prasanth Kumar Padarthi wrote:
> Document the ASRock Rack B650D4U BMC, which uses an ASPEED AST2600.
> 
> Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index b7e70868e..3e6133e2b 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -79,6 +79,7 @@ properties:
>            - enum:
>                - ampere,mtjefferson-bmc
>                - ampere,mtmitchell-bmc
> +              - asrock,b650d4u-bmc

That's v9, so where is the changelog? I see in cover letter only v8, no
links to lore disucssions, either.

What happened here with previous versions and reviews? And why is this
placed in non-alphabetical order?

>                - aspeed,ast2600-evb

Best regards,
Krzysztof


