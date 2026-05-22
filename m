Return-Path: <linux-aspeed+bounces-4121-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86224CD5BB3
	for <linux-aspeed@archiver.kernel.org>; Fri, 22 May 2026 17:44:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMXhW1PtFz2xc2;
	Sat, 23 May 2026 03:44:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779471851;
	cv=none; b=CMTj4m+z79NdjSeqUma2KCIae6Dn50ewj0zy5xbSMuei7CGGupQbsVQFDLzKMwubn/fdE3T7IILPbdEb5dtRpTnRr6pyIb+TMsJb+tJzbRxjofL5wOit1nyz034wdCRSEteMfVTcwQuJy5HE+h9dfrqwzJO87SkMjKEcLk6zl+fYtQzAT3GN3vFlEgDun19SZqda9jrTu4gdIxxXHCNSitVWkIBZy5phRSNqA6deMe3r3YrLxIne6HiE50u2YasbBW7ZHqrrw4yzoXUwJoVpJmLlkWbQqajiKtQ4Y5KS3YTQDegI4dlfrR8twE9SKgQKtbQlx6ZoFth+0lc+/UGVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779471851; c=relaxed/relaxed;
	bh=dPSy7gqM18tB/riDkEZyZMz/5Nf/xICtVmHbdFXpqic=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QBedtXvsLrw39pKvnSsnrbq670crTligUSBJOmVO7hFwQPZj9kYsj1hqZ8ce6368ncH3goZ4SdL17TkjRsylegJb5B0dhZaDpAVTTle3OKv/LbrTDiQCUN6Ydq95AzobEMbdA5dMI8EajWoQzvuP9il8QMjnbKqQbFxQNLTr0KUCQ+17l/QDVmy4xHeb5/FEYTkzQdYvEV8g8kANPs9FEFUdJYYiTmIySQfeXNp2ARpc2ULulSP5/uj12bq+oRug2ERNqhf6WivYz0FJWtckvlx+d8Of+OfI3JuKKF0xCd2S8nPfvfH6sfBRwMxJjlFRGQ7GWXFnOZi5R2kjmgkkrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EDaTfJ7X; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EDaTfJ7X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMXhV0DW4z2xK4;
	Sat, 23 May 2026 03:44:09 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B578460138;
	Fri, 22 May 2026 17:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFFC1F000E9;
	Fri, 22 May 2026 17:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779471847;
	bh=dPSy7gqM18tB/riDkEZyZMz/5Nf/xICtVmHbdFXpqic=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=EDaTfJ7X17s+5b2rhHQNVFr4NtSQBZYy0GGlC9Lss5cvXCZRRNDUgWoSMZHh0gCrf
	 m+zcWfmdFkDgeKoyfvh80h79EEP+SNRsNeon2geS3sXTP47IZj1cs/BFDCFaUF9Qsx
	 vQatlyTlr8YbPnmbwh8MrS9zt6Jf82TQu11mv8VCYsdasNeC0lAFXynrJZgnUA7lPd
	 THfCNH7j6Mq8SIhd626f2kIu70q/AOLCC0C+atNfWtBVGDavevc0QqvTU/nIa26h1Z
	 f0HVAi71gu0OFLmUoUzk5akvmHhiyKm536u8sZ55NcthZGy7Vo3cptcHBstbCtjFaT
	 XDbaAKIyGgoCg==
From: Mark Brown <broonie@kernel.org>
To: clg@kaod.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, david.laight.linux@gmail.com, 
 BMC-SW@aspeedtech.com, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
In-Reply-To: <20260522071621.102507-1-chin-ting_kuo@aspeedtech.com>
References: <20260522071621.102507-1-chin-ting_kuo@aspeedtech.com>
Subject: Re: [PATCH v2 0/2] spi: aspeed: Fix __iomem annotation and VLA
 parameter
Message-Id: <177944768300.6494.4828834856275675415.b4-ty@b4>
Date: Fri, 22 May 2026 12:01:23 +0100
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
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Tv9yC/HPHD5MYTDVZZjm6BiKOT9UVVCDNhlVmgG3Lic=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqEJXkT2orRoPdoYnnzdEspQaf3e2CYyRio3QVd
 FZwd/M80uGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCahCV5AAKCRAk1otyXVSH
 0Ng1B/9At3GEzpYWjnScrGWwjwyY5BSXn4qiWVk8pSrER3UFOq7Q9nblg/f2QpceDCw0n4CAJND
 SgoOGI+Bpjt9+PMLaR3lqv5yTW4Tlp2nvUbQyluqSWEWasUSOEXNRNBg4p3IQqp3WaNKSiCN/gJ
 wi7+LtWEgLuutwhJwtyETdaS0REBi+4ECFq+2y845igEKu20G6MMbhrc72Pi41nyx9qIZf/fxlc
 jG+bQCtiCJU+jSyaPJeOXyH23BWB65ycUUBNya1OnWTuokWiAlxv9GFhmSYZRJc+MVhEhPwN48x
 NTxehS8KOf9UUBfxigVx7XBOFeFo7lH2Nsw1sBdEE9dT3Qsx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 22 May 2026 15:16:19 +0800, Chin-Ting Kuo wrote:
> spi: aspeed: Fix __iomem annotation and VLA parameter
> 
> This series fixes two sparse warnings reported by the kernel test robot.
> The first patch fixes missing __iomem annotation on an MMIO pointer
> parameter, which also caused a redundant cast at the call site.
> A VLA function parameter warning is also fixed in this patch series.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/2] spi: aspeed: Fix missing __iomem annotation in output transfer path
      https://git.kernel.org/broonie/spi/c/5c3091e23f8f
[2/2] spi: aspeed: Replace VLA parameter with flat pointer in calibration helper
      https://git.kernel.org/broonie/spi/c/94f5efbaa751

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


