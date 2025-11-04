Return-Path: <linux-aspeed+bounces-2738-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814D8CCF9E3
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Nov 2025 08:23:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d11gv64ktz3bfV;
	Tue,  4 Nov 2025 19:23:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762244635;
	cv=none; b=oR8g7S3P+KOr4QYoYkcdJlPmjo6VTP5SUB4pWJ4u5bwra1m7vKtmi4slWul2PINdKsSdJuEXNWrNQmKdpJ7o6XWr1q0i2SSOD3Si375omXmXI2naApHg8pTw6gxS3SVzxM3ElWvYdchN5GK6WBGWe4QuCuKAOE60abzJsF2m8wTBEHmNufP2M107PB8QCi0yhnv3H0djyIJb74oTvDZdpYiK8i4NpmZabdKTzo7GTW4kKJrOeiNnBf8wzV0TUBtHGJYWn2+uG53bu7VKY8/4+CYotn7s0SaZQU9+X3fLIVKQeKcu7wXt0CAJCHqvyOHktBZ3KJACufe0fy8RZqCKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762244635; c=relaxed/relaxed;
	bh=acjutq4oYtn238t5xHhyqykBwixbji6v7lYcp6vJWv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amqeJSvWfH3MfKfyAvFVv3wxkbw1WdYAh+6ojuwAnlJo+BeLbgF3xzAFWc3vfWoYNqafcoAct5NzI5BD6Nc7cNcPi5Do3MTf6tMIcy2c0HdylmKRcUCTxt6rawo6Z2IX94f2gi46lGYIEdw/w3kgTjNpgFTR2zzWENl44q6VNtg3opxMM2kZm8VnnDDeK91mBnzOVKt1ZlAU2m6ghpdqH4N7m4slh2gS0LxDuZYqnnbYds/Loe3VGtqHZu7vof58fH5tm6jsb1+KIylH1qHTFIradHecqh3wkf6/y8X8je2hnnunzNq2baVKhhQKo/368IwEURkhQf9Uk5h1Nq1ffg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=j7xPuPhq; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=j7xPuPhq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d11gt525Lz3bf8
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Nov 2025 19:23:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 351C1600AC;
	Tue,  4 Nov 2025 08:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53442C4CEF7;
	Tue,  4 Nov 2025 08:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762244631;
	bh=eKJUNYg3k9kAkrM1K2ms5vRzV9lqnBJj9YdqG9NsI/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7xPuPhqwQgc1yr+DO7h4WkCGNei9+hjF1Durdj40HMkGetEt2MlQf1UwAtmR/OdP
	 0Z0fed1MgnO0sqfaZ08FG5I9RpRfyLFByqVk4NhbwWOzDxC1xGCShg9d/2w67ynwTU
	 fAHfpCUZ7elvCf9gS9g9TdjZyrFSlydFrcMazhxmqu8wmNkLDpeta9BThCMfTJ9n+1
	 AP+FUi8Nwzm2+LjkB6M+oP7HjD78qo4TboLvFaYCxOboDq+g2gCVAgu0l5//MbMm68
	 OGIql1KTzpd5dBQ67isXeSb/vVcfQTdbnCmMNrghRIR51IZeBGrCKwiwsK5knMcSr7
	 XNoAtlHGa9dSw==
Date: Tue, 4 Nov 2025 09:23:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Shen <sjg168@gmail.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	peter.shen@amd.com
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Add Device Tree for Facebook
 Anacapa BMC
Message-ID: <20251104-fantastic-merciful-giraffe-0cbf87@kuoka>
References: <20251103093320.1392256-1-peter.shen@amd.com>
 <20251103093320.1392256-3-peter.shen@amd.com>
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
In-Reply-To: <20251103093320.1392256-3-peter.shen@amd.com>

On Mon, Nov 03, 2025 at 05:33:20PM +0800, Peter Shen wrote:
> Add the initial device tree source file for the Facebook Anacapa BMC
> platform, based on the Aspeed AST2600 SoC.
> 
> This device tree configures the platform-specific peripherals and
> aliases for OpenBMC usage.
> 
> Signed-off-by: Peter Shen <peter.shen@amd.com>

Broken DCO, see submitting patches and checkpatch.

Best regards,
Krzysztof


