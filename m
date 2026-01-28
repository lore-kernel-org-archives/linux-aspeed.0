Return-Path: <linux-aspeed+bounces-3435-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4656DD25B59
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Jan 2026 13:06:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1Mwl2Mrpz2xlK;
	Thu, 29 Jan 2026 00:06:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769605591;
	cv=none; b=Y/SZiUJMUn+gT1C40/nf7QGIpaBgiLaKl/ImZZVObVgdpeAFPgzO5dC4Q4yJvcYHI8PZDphMS21Y4WkI0Ld4im0TRfglVErPTKo3GRsYzk47icMVAEux8IXsuWB5qTe8QnyX3W/AA52dV/IWapHBq+BOGQ7jQU3FNzI1/8Lhl3/covlQOHpXkmLmcu2Jou99DvjcNVjUvD3zUl92W8sY+4rZDw9dLVchXjLBU3V962zFl+mCFFW6CeZObxXd98tBGjydnhIZY3YyXehiZ07Bo8YZ223UU9AbYLNz0U98aYO67sWoPTThCiPGZ/7LrQea8NpWNv2n1jac5VOt/SHGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769605591; c=relaxed/relaxed;
	bh=97x7WwgT6x+N33UvCKr23GCP4mZ80klZJKZvCsojamY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ztjm6jhCTtMONc1oMSPzKuW7jx+BMh2IqasWvN9oirAQbYfxXyaYWWpcyw1l58Sq47GCSBQcbZTXl60YUVnVmAAMiDW4WLPAjqpakK3TkCsifMKeFdKL8ZGE4iWFWiPxMLDkhjtOWPNJRjwKkig0klNVUygW2ZLSpzWf+mFwi8ig58b2iU0dTt5BsAZYXBoc3mcx4V85qsYAFxF4qZ3nB2SCCk7b1j4qyzzyy0/Bnjvd4/pFmnu+oDWBKS40ZH/dbtdck7F+JTA8yaY2uPvzJMI5Q5FOO/hNPHK9zfykiwC8Nc9IXzPMZKd2ZhFof0gvKPaudBhlpzzmgR75NHtmMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MCsYeive; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MCsYeive;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1Mwk2HtKz2xjK;
	Thu, 29 Jan 2026 00:06:30 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6C1D043703;
	Wed, 28 Jan 2026 13:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FC1C4CEF1;
	Wed, 28 Jan 2026 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769605588;
	bh=r1fZSr0IvTlpuB5HuW79n7uRT9PQV/E04hDgpki1sK4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=MCsYeiveMYPiB7ZQExQ9ogtkxyQWW3eRgEK86jrT+0LHPiEqT1AtRnyk2UbQ/9ip/
	 DAneno7wnREaFR8NlvLUh0VLtAGxu97Pxe8Docd99OuI9vdQfq78xTRLEwbTp18cWo
	 36kbAW6nCjAv49rcJS0/QhnlnhMKf6/GVCLX+hKGMiZOiF+bwlNMHwvhhd6lxP/YMM
	 5D7tVIGEs3B6QI+2q2VN2/q5Y2OBajeP+zdYZV6CU6dY5jlGXfhaCLrsXv+ZiFPnqi
	 hQcVMqc/qZhnv1ZUv6/3q/8arNGjjIyBXHS9RYx/ZB39v2LhA0Abdk/9x5PZlelNTE
	 lRMtuIXj5NEPQ==
From: Mark Brown <broonie@kernel.org>
To: clg@kaod.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com, pmenzel@molgen.mpg.de, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
In-Reply-To: <20260120123005.1392071-1-chin-ting_kuo@aspeedtech.com>
References: <20260120123005.1392071-1-chin-ting_kuo@aspeedtech.com>
Subject: Re: [PATCH v3 0/2] spi: aspeed: Improve handling of shared SPI
 controllers
Message-Id: <176960558580.1648911.5452842376187241181.b4-ty@kernel.org>
Date: Wed, 28 Jan 2026 13:06:25 +0000
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
X-Mailer: b4 0.15-dev-47773

On Tue, 20 Jan 2026 20:30:03 +0800, Chin-Ting Kuo wrote:
> This patch series improves handling of SPI controllers that are
> shared by spi-mem devices and other SPI peripherals.
> 
> The primary goal of this series is to support non-spi-mem devices in
> the ASPEED FMC/SPI controller driver. It also addresses an issue in
> the spi-mem framework observed when different types of SPI devices
> operate concurrently on the same controller, ensuring that spi-mem
> operations are properly serialized.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-mem: Protect dirmap_create() with spi_mem_access_start/end
      commit: 53f826ff5e0e3ecb279862ca7cce1491b94bb017
[2/2] spi: aspeed: Add support for non-spi-mem devices
      commit: 04f7516ab70f7b82aae1d2830af2ee6f17f3fe98

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


