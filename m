Return-Path: <linux-aspeed+bounces-2456-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE7CCCD193
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Oct 2025 12:14:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmqkm3Tdhz3d44;
	Wed, 15 Oct 2025 23:14:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760530448;
	cv=none; b=Otr4cdLjs4xFWwswJzhscdp4swI9R4MZKEwYPXD69GA9e/nURMm4YjfqPopb9Ku0xAsdOY9ll3O7JxlsgmQoFVlOLZwrdHOlxLZlO0i85uvBXCjqVrDr5F5YEKrzL43fh/20HHDWZqkcpfeJl4EKVyS+kKIn/9ikfWo/tE9xwLeivwXV6yZr4K72ZwU9BouAwC1vG33ufkE/ovndNZAp9b8YhJK4cMCSXdZgNjZNSEHaTOWH9SzsekHoe2PL+C2YzoL2NQUtoi8n81jE3KRPsTQxBqTKdEg0//cOaDevmgo+RGy1IdWcuyST99nIQ24DY4tUwNTAG91GvwU17i9l/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760530448; c=relaxed/relaxed;
	bh=f3OimdfZgjfY9/HT+h0JoDDZq5EDc2SRALwvB4NSvXE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iEGAw7FfEMyPb0Vmy9u7p7Dk4f78Cs1r5iRkc/WTSmH4sJShtrukc8eOGX+Wx7IIjSBJNknd/hMg+pRtIPoymk7CS/ZMb1N8isKCS65dga7uNrL8460+YaMbDHWpftmMl7/yiXfJS4wKC3Tp2FiNhoXjMVMTBSpxxm7qw1bTEHp98lSN6uRL3VRNBs2vbhouBzxBsrqksQDQCR4bqfKppa6G8x5PGoAN9HlMYWx4tVTT6m21nnjbZ7txDf0U0bYP1fJOkWeU3Ba7yjML6Iq0nYHKJKiJCYD0kEdFSixPbNZgvhvqZWEpQwg39KOAdlpJhI2gPOmAu2bpbWvy0udD2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o/X8KPLm; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o/X8KPLm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmqkl43lXz3d3W;
	Wed, 15 Oct 2025 23:14:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BF27845140;
	Wed, 15 Oct 2025 12:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30FBC116B1;
	Wed, 15 Oct 2025 12:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760530444;
	bh=U0qBfTAoLQ2lXuxhHDpAiZcucUrXqzfYam7mxeAjgzM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=o/X8KPLmQwvaZ/4jk3aNbggMUsmUtSiTRQlSMl2XJzeWcdxeAHYCVUEkxd4xyQRUM
	 lm9j3UxOz9eAQqeEiw4KJtqK6D9JhqFpzt824g1F5aOEiD9IDRQTb4jnryGTQEKfOs
	 iAlvzz2RFp1CxWICKQO4xi1XyoRewABj3vRnEl7xWHSRMxzN0SpSnDF43LOvksIYR3
	 ACtYefsh+xgYcs1L5mX2EWAr4I/iNRCtLcWAjJJMe7vdTvlm8DBDul72BwYuelziYo
	 OjknTg03VXAm8mwyc8gDIxE4bHcrkdHE7kiuKHSn2QefE+Gc9U5X0I+y7ygwupdVFi
	 /eyOx9e5W702g==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 joel@jms.id.au, andrew@codeconstruct.com.au, clg@kaod.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org, BMC-SW@aspeedtech.com, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
In-Reply-To: <20251001112605.1130723-1-chin-ting_kuo@aspeedtech.com>
References: <20251001112605.1130723-1-chin-ting_kuo@aspeedtech.com>
Subject: Re: [PATCH 0/6] spi: aspeed: Improve clock, timing and address
 decoding logic
Message-Id: <176053044168.105519.1540910122531672579.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 13:14:01 +0100
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-96507

On Wed, 01 Oct 2025 19:25:59 +0800, Chin-Ting Kuo wrote:
> This patch series introduces several improvements to the
> ASPEED SPI driver, targeting better stability, compatibility
> and, flexibility across multiple ASPEED platforms.
> 
> Key changes include:
> 
> * Clock selection strategy update
>   Improves fallback logic when timing calibration is skipped or
>   fails, ensuring reliable boot behavior.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] spi: aspeed: Update clock selection strategy
      commit: 31dcc7e1f8a9377d8fd9f967f84c121c5ba8f89c
[2/6] spi: aspeed: Improve timing calibration algorithm for AST2600 platform
      commit: efb79de36e947d136517bac14c139d494fcc72fa
[3/6] spi: aspeed: Force default address decoding range assignment for each CS
      commit: 630a185fd06109193574d10f38b29812986c21de
[4/6] spi: aspeed: Centralize address decoding region management
      commit: b546e0023a203e7edf9377ac8f4f490a6965afd6
[5/6] spi: aspeed: Add per-platform adjust_window callback for decoding range
      commit: 0586b53d4a0c7c5a132629f99da934cc674ea4cd
[6/6] spi: aspeed: Only map necessary address window region
      commit: 64d87ccfae3326a9561fe41dc6073064a083e0df

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


