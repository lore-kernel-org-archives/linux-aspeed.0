Return-Path: <linux-aspeed+bounces-4206-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4879BCD8C92
	for <linux-aspeed@archiver.kernel.org>; Tue,  9 Jun 2026 12:05:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZSKv6fpvz2ytV;
	Tue, 09 Jun 2026 22:05:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781006755;
	cv=none; b=OFWbLdpnMZRZVFqUvOzK0kI2gT7LGdJCyc2riRw0ZYqfHya/9CEmZEFwG6fzZ/QvbLay3DoYwaRymj1F1RxWBbZdZRFwrMtBBcqxA3NXo8Ix8HCtsh/SfG6hoNbWBZW10A5y/jqz0JJY17V4obeejy0hwfrIw3fAy6kBy10a84rjzu7qQ7XtTwvom3ERpMvNaZEvjSil4kbAHWZb+7bfkM60/WZnRfGuCbppxCTbDyiOGlER15u0rUOUxnH7gjFS5/3VYNhOVpxg0bdTHksX2REGJjMfU4xiLpoOoRXcCVyMBUt2lWomhuFcKp6M7+3PBzUqQ12rmfm9jfrEHBnamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781006755; c=relaxed/relaxed;
	bh=g8UFSx72RbpMItY1SQYyOWf0b2YOdayj8KbARCCd1rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckMKci+7IZ44jfqLlL6MJZJub1aKDhqn76kyiGvrD1C/hZCahiDWqBYat+dOPMih5d/0Tk/sbGPYs4VOVig2luTBgxm5skEIcuu6M4GClVODf7QiXbKbDe1XEKOqEZVDKw7+yCLzhNwrlyIwm8UHOsTT1bpp/yz8Z06QbKp76TAszJJAwoqyBUu+vq0bv/0F8mda8D2QylyYGooBhxJqu8LCtnRx2BBTTrJRK6gVbaqougM9nqpxH1QN089EXC/LxTGEz4V/K8HCN8nGjRsSseWicw3qfPxl6I2v7ZhXqCVWHqZWdKspjq7x4DrfO3KksS7Po0f4glDkL+AESJ4F/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NBAi9LEJ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NBAi9LEJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZSKv03zLz2ySf
	for <linux-aspeed@lists.ozlabs.org>; Tue, 09 Jun 2026 22:05:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6EB3B601DC;
	Tue,  9 Jun 2026 12:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CA31F00898;
	Tue,  9 Jun 2026 12:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781006752;
	bh=g8UFSx72RbpMItY1SQYyOWf0b2YOdayj8KbARCCd1rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NBAi9LEJgz0xgPh8Tv6S3ZF/2vmonRfnQ5eaTzjG1O5Iv//jlKEi4+ior2wD9Y3aB
	 L3sMnpac4VuUjiuQ1ns/kbSMvmft1DKwb7b8f+OR5kazE7CTjKUwY+w9cBkXZxhACs
	 AnBtkinRqAvGoX5IYJRH/AuF9K2OIRbCagoO0NCMgw/tAnQA5AE0kDArU0bfZo5s8m
	 vbNjkLLX4iVgCMM7CbzvH8SiUj5xcNRFA7FjtnLs/JCNq+m/1hrGdvsSGBgmuiekdR
	 9m0Ypz6cOg/UkEBRyr3oOIQd4cJKHceknQYhZ+TOv8AuuO/txld8hTmL5cKPKE/KuU
	 ullBC9AH4h2ag==
Date: Tue, 9 Jun 2026 14:05:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: soc <soc@lists.linux.dev>, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [GIT PULL] aspeed: First batch of driver changes for v7.2
Message-ID: <20260609-terrestrial-magnificent-loon-24eabd@quoll>
References: <6b6b592163523beea48e875a047afc8b4bdbb00b.camel@codeconstruct.com.au>
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
In-Reply-To: <6b6b592163523beea48e875a047afc8b4bdbb00b.camel@codeconstruct.com.au>

On Wed, Jun 03, 2026 at 11:15:25AM +0930, Andrew Jeffery wrote:
> The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:
> 
>   Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed-7.2-drivers-0
> 
> for you to fetch changes up to bc13f14f5cd3d15054de38dc1232b49343d36297:
> 
>   soc: aspeed: cleanup dead default for ASPEED_SOCINFO (2026-06-03 10:47:55 +0930)
> 

Thanks, applied

Best regards,
Krzysztof


