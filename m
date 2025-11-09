Return-Path: <linux-aspeed+bounces-2847-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2DBCCFA1A
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Nov 2025 15:04:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d4GKM23zlz2yrm;
	Mon, 10 Nov 2025 02:04:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762700647;
	cv=none; b=ffbrZCJ00W/LW5Vf9Z5b6j6WcDDiOeflOuWCUNL19adoqDh7T7jBKkHE3UzUFHUnBwIeL92AYvLiPtWK6bxXFQTZiXAF2qypUQWpAMDVt3GYBTD+Z6amvrOsPDV3dBDpG0rE5Ax3Jvm2iK54WvNqRsdK3+HCS3ZY5dC7o7yGfssx7a8kBi97QP/W3gWXWjQnvkuyiMqfyKK75YI6H9Rpk2+BsOPg5woXivny4bgKEaSK4X6zuzpobjnoXKoO6v8x5zIXOuYlErMImiTbR+LZkDHLRLZD53Um1E6zbIocsNAuRrA29t1rUSS1qJ9FmiKi+jHtjLFnCoURY09iRpOG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762700647; c=relaxed/relaxed;
	bh=o8wlgQwiaapKDvuuMcG/LHnApbqP6But5sj6HSYDOJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDdn0ElMywWUg7NRiE8GF7brmZX3vNff5qStDGh9A1vUQ8mv9gdw+vsBAspzs6UwKwMRQsejq873q/r5raYiIUCF6AQ+U5TthbhfDMoya/iLrTcxftk7GS42Jm/v5SjCJa/teYb6XBtsuJLij/6X3OUz7r5zxOmz6IEVJTV0VtyCVug/h7mSlVubBarMjbPXvN2HglTRVmq263U0IoltDMWxuakUpEixAUbzlAdJtA07O2rAayx34EaREkMtR4dhkDLAYJdNLw/WGFa/Ho7SXuGn2qqy5ghlwn3cEz5UhL1W4BB6tlKKbYXZxwfznGLaxgJQ3umBPlYA/i9Yqz8+dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DkIOeFV1; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=DkIOeFV1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d4GKL5QRpz2yjr
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Nov 2025 02:04:06 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5468D402F6;
	Sun,  9 Nov 2025 15:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5045C116B1;
	Sun,  9 Nov 2025 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762700644;
	bh=IUXxyPcnqpDHiv1qOb2dy4VYfAq79Wb3o8hOBTShskU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DkIOeFV1+f18yDyApLUJy74bTRcPycSJScKMDXtjh3tIhxmXLqADiOOBXZhAF0uqo
	 h3rVu6lHHaCdm2TISoR9+A117zDZhQKc8IM4iXJSOMDV7LaHpYL6eK3nMWlDBiLRur
	 YBD8oaHA44QzSL665ddvLAmpZvaph/jDhKh+C74COZxwvp7q1k7PxUIyvLiUA/USjB
	 czfi8cgRi9iyQo3bV3TOzBNxFs0QDaxxbFOfxh3WB23vr+yHNKCQC2o8FPr3vxUx33
	 qlBAE3cjey5WcPjgh3W4IzGu/U6zai62L5drBm1ksFsV6wJKgHOhbrjVLM7oyNQM5q
	 5fmyCrqvVBVLw==
Date: Sun, 9 Nov 2025 15:03:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joel@jms.id.au, andrew@codeconstruct.com.au, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: aspeed: Add AST2700 ADC support
Message-ID: <20251109150357.513e3a25@jic23-huawei>
In-Reply-To: <3d2fde56-d82e-40c2-9d0b-2888160a642b@baylibre.com>
References: <20251103105217.1764355-1-billy_tsai@aspeedtech.com>
	<20251103105217.1764355-2-billy_tsai@aspeedtech.com>
	<3d2fde56-d82e-40c2-9d0b-2888160a642b@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Nov 2025 09:20:48 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 11/3/25 4:52 AM, Billy Tsai wrote:
> > This patch adds support for the ADCs found on the Aspeed AST2700 SoC,
> > which includes two instances: "ast2700-adc0" and "ast2700-adc1". While
> > they are functionally similar to those on AST2600, the OTP trimming data
> > is located at the same offset (0x820), but uses different bitfields.
> > 
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Series applied.  I'd have preferred a cover letter given more than one patch
as it both gives a meaningful series name in patchwork and provides a common
place for replies like this one.

Thanks,

Jonathan

