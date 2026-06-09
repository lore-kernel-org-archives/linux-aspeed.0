Return-Path: <linux-aspeed+bounces-4207-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891DCCD8CA4
	for <linux-aspeed@archiver.kernel.org>; Tue,  9 Jun 2026 12:19:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZSd129zhz2yv2;
	Tue, 09 Jun 2026 22:19:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781007541;
	cv=none; b=fYjVCYeVT/4ZmAfhgkGyq/trfsIX1iD5IBsIudSBtZ0X0N49qR+dvAoyq8zAdMZTieT2zotoJ6eSw1a6RUFH9tRBOCFrIKXpwYfHUJ8SyY0xqpVO2zxwfgF6jXwtICp5b5x7Mf/ugbX0EbpSA/DW5YcQLS9haA9VxpU/NWxyeTe3sWTFQvsiyW/zlqNXaN7aRom8zpOQRbHhuXrdyMavEBJ9+la9L65FDSOZSZzutd0zCJM+VAghVrnulM8Cdi52IZTL8RxGb+elvDKKigR6BPbT6C0JXuN6zFbdAUr0JaVRwSH52Fzb/eOxj0BIKJ4JX3od/6vLq3UOM7bZJtDsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781007541; c=relaxed/relaxed;
	bh=vDOEE8xBUSXxvq4xLfdOp0TCxRvuaF7+Cmh+3kfoHpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCp3GUlYjMD00T8LoObAHB9cgp95HIGCQE0xkrdw06jp49H/YK8hksvqTikDxb2kWX+37t9FQYVcuGHNEhMz05iTTQJ/dnR2gkpQweuzvAUVJSLA3dQcqHVJfD01AXxp4GLzoq15f6vgB85+oeTASaxPup0dqxxV2NNLtDOyhOV1AKF6vGRqk6qUSMoOKYlxFH13pmfMoZYygsX+O73rjthMT5SDTstZD3OGiclpNCiyejqlcxW9bVmb88jKPdMrjJp6iI7htSivCzHxbS6S8V3ptJEHdfXXfOOrj5L5Ho+TPnNCgyl8vQzIuf4J3llVk2nLSkQu1uX631XmScnh+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUrsJUo4; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUrsJUo4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZSd04jM7z2ytV
	for <linux-aspeed@lists.ozlabs.org>; Tue, 09 Jun 2026 22:19:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1A3FC4353C;
	Tue,  9 Jun 2026 12:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE091F00893;
	Tue,  9 Jun 2026 12:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781007538;
	bh=vDOEE8xBUSXxvq4xLfdOp0TCxRvuaF7+Cmh+3kfoHpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nUrsJUo4SBKUrJ95fNqHM7pJvu41I5sV4u6qmdzT46KMoUiI3QxhnETMEomM1BtgF
	 wwaQL/RoH5HufkUOZectSI3noKVXotyShS5hikS4/xGVaGHzXQgVRALWFpNSLv4aYh
	 Gey+VJ+gxydk9kYpnIuoGKemrS98uO5GM5ATv1knOtXYsn71FnX3YbVaLM+8ITLkuS
	 D6TWh3teAkMZFabGIlK01zvI9Wb7JyqsopMHLibnqbW6imSojLIiRVJ+eB369GeaGc
	 ITPlPwPtKqR8wraGxn/YyxqOn0xg2qhZrv1O49cLoo9uyOFKfLSr15B5KMvuSoH2j/
	 HtkYY9mICf1lw==
Date: Tue, 9 Jun 2026 14:18:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [RESEND,GIT PULL] aspeed: First batch of ARM devicetree changes
 for v7.2
Message-ID: <20260609-axiomatic-bizarre-boar-03f773@quoll>
References: <cbd2822caa9fc7c2b4567703be785b9b4fd829cd.camel@codeconstruct.com.au>
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
In-Reply-To: <cbd2822caa9fc7c2b4567703be785b9b4fd829cd.camel@codeconstruct.com.au>

On Wed, Jun 03, 2026 at 04:48:43PM +0930, Andrew Jeffery wrote:
> Hi SoC maintainers,
> 
> The first attempt[1] missed the preamble, so here's the same again,
> this time with it included.
> 
> [1]: https://lore.kernel.org/soc/55ab27bc5e09252b1dbfdf1505693eb193b8e846.camel@codeconstruct.com.au/
> 
> Cheers,
> 
> Andrew
> 
> The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:
> 
>   Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed-7.2-devicetree-0
> 
> for you to fetch changes up to 1249ee157de518a76cec169e2a5db4d6e523cc90:
> 
>   ARM: dts: aspeed: sanmiguel: Fix the CPU_CHIPTHROT linename (2026-05-27 12:44:26 +0930)
> 

Thanks, applied

Best regards,
Krzysztof


