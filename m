Return-Path: <linux-aspeed+bounces-187-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73497E77180
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Dec 2024 13:00:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y6zPN0bGxz2yGM;
	Wed, 11 Dec 2024 00:00:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733835656;
	cv=none; b=A0lpb3VzwufNiZahLE2yYE9P5NnWyE8+lsWdQtlaELBaRQ7Wxlv1LoTJmPti3ekq+QHTz+ostkHC1JD/CzM2KZyRs9qpPzVewmeFiz2bJRbuaDKsmNDncRgbNDRcQ/PQu12OQpO6Ss3iR+nka9OU/W9HNMrwg7kU1Jy3sDU2fc1e+4Pu9nHQe8yktnYKPSl+fjA1gId13fKbhHPCOOTFEcFW61E48qhhzZ+woytoxaLB62512RoNZDxyCQZu/heO3dWdBX02Pyapwyn5yUep6sCTFY+b4AIGha5D97DDjXA4PLLPAyf8VvraNAZ2zLNJBvMa9fInLHMzLBst8nb21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733835656; c=relaxed/relaxed;
	bh=6s1Y6p3w5g9RObkM06oK2W80+/bjnjpN96L0wHyxeJs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=at4jpgZKnCXyunkn5AV/HALLkrOSQQ6QmpbgZA7s/q+TWNsRALlpbvmi9Dh+KrpXySCqTAAhBj3wh6obsVPWFBusBPW9kZGId9vCxuiX2NdICYCOSyuJgcQLkUx2q+y6c/wJNGJAS1i3xjJy5JNQi5et+iayP++inKekEkkvDbedjA+k0HHRaSx61LUSC62FkanOWPtPXrNgRuQUsj91Og2Wm7dTud50BIG4wRRw8AXce1Gb4yixkFrVmbSMo+07/+zeaOO2kTQBaFvog75vQ++D/5GQe/t2fhTbKZzz8vYek6CkntgBJ/2BL2BoqHoKWRre5o2GKfcoiPEB9YPpDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kF8HjOEO; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kF8HjOEO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y6zPM08Jrz2yFB;
	Wed, 11 Dec 2024 00:00:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2BD2F5C5E64;
	Tue, 10 Dec 2024 13:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63526C4CEDF;
	Tue, 10 Dec 2024 13:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733835651;
	bh=jaThpRIjcCNZ0lQjQ42i7rnft7gfMtJKkGlTrJdutek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kF8HjOEOVQLLfosqKYy2yxSmojOUK9dE5AA0qn5ypsIUCqMuvvubvy0hKGiYQ8Xor
	 6795C5de8kjVFtlMwiiO0yvBtylBAJx9uLg2QTrUhj5LBT5gc8YXjxO05YOmVhg8W+
	 0qJh03WHF00pbCa0+Watf5W+S8lygjvV2SzdapZuYoYrn+0OOjY1V3FxUylPh8QjU0
	 tQ9Jme+ujIAPmykTpGt7yA/94UwUvxyAPnO5Ouf8L27JwQK3ismNTAfGbIb5IlDVlR
	 n239MCpWHdhRAvcEwbC2K+wkt+X/bK8qXG3Qxvsbgm9FBdOXG0wlyWlvBl9AnIxSYy
	 Fj80hDpsJ6ALQ==
From: Mark Brown <broonie@kernel.org>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <4052aa2f9a9ea342fa6af83fa991b55ce5d5819e.1732051814.git.christophe.jaillet@wanadoo.fr>
References: <4052aa2f9a9ea342fa6af83fa991b55ce5d5819e.1732051814.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: aspeed: Fix an error handling path in
 aspeed_spi_[read|write]_user()
Message-Id: <173383564913.34030.1229101307217258864.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 13:00:49 +0000
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 19 Nov 2024 22:30:29 +0100, Christophe JAILLET wrote:
> A aspeed_spi_start_user() is not balanced by a corresponding
> aspeed_spi_stop_user().
> Add the missing call.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: aspeed: Fix an error handling path in aspeed_spi_[read|write]_user()
      commit: c84dda3751e945a67d71cbe3af4474aad24a5794

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


