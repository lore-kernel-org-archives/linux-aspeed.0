Return-Path: <linux-aspeed+bounces-2737-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38541CCF9E3
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Nov 2025 08:22:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d11fR4Bsvz3bfV;
	Tue,  4 Nov 2025 19:22:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762244559;
	cv=none; b=dcY9PyS8I8LPti4OUiiQkjfziIwEN+aTL8vH/H7yE3aqn4c8/S8Bxnv2pbZ/oeKdFMakbo/9wGzOTUvjydwtemMo2u6LiB3+OjSPIx1HdljiqcRyC/dxNtF0cKEhdBm8XaDcmJaJ0OX8BNMSSMOi4k3GRP1EtmsaoO3u8W+wo5aplkOrIKCHMUHTY1DMDkzu3GyxucwjQEd66/mRnZNj9vvqFWs4jORPmN7mqOiAj5t0k8oL82kAloGnKR137Lj5luS2flJ/aTv5Ca9rGJpi24U3DXf9s7gyGhT5tf6LiKdJrqAXorLNJ4OQWgB36iBuLdxh6EoX72pE/iFb8kZ1PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762244559; c=relaxed/relaxed;
	bh=/1hWH3+AR/bg3QpRh8gvwyFU649vBca22dStUU7iirU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuUKB2if8oanCCrH9oKMneylelDndgHpF1EXyJ/M3nzDJWluhKeGuJ3Q3mx+HxR2hFOm8zg4MqF6vbLdCt1BVfx/mMhOFQFCnGDO2BHFcw1Mz/EoYieFGmvxdDvV+2ZDm+wvrcWoujWQO/Mk6dsXaXJVek8TQbwYHfw3TBmRSqoyp/ATYL4TX0tL8XLQ9WlKs+bvx+Lki/tHLtyGLPfJ0v7w9kvOaaYRIIgzY4dxO93c6pzO9PXpsj1iFqUnZjmE27doaSJG2wePx83NxvExt5g0OK+UZ8Gka+g/V5PKYVIN2qVuPkgoQkiWTFCtUyf55ymQL+ZZHqN2tCSXwBreYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZPbwNonw; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZPbwNonw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d11fQ67F5z3bf8
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Nov 2025 19:22:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C8FE1601F3;
	Tue,  4 Nov 2025 08:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D539C4CEF7;
	Tue,  4 Nov 2025 08:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762244556;
	bh=ReIHYoZ0hfuPqjEQELfx5zZWt5YlSXlsiSnCN8jUknA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZPbwNonw93eAJJvAlPi5vo8zgVf76U06SpHwN8KcdItl2PD2A2gaGXwc6ZjgWx4uS
	 wb801lM9uqwgMc0JomOoA+VmFd+G2mvXpEZ7ddbT+wQyqcrhMHOEgeV27krAw5KbxX
	 2KU2rKAJO6ZuWiiPrrm3YwlXeVMwGrBbz+YyXho3rjEu3tuVIIx0UkuFxytgLmMNz2
	 kyB0Gott5qFfuh3RI6jNeECSOkrtWGvlhrjJPzyTzGSjBJPfqEWZi8NYgsp60vA8P9
	 U6ERelUNMVbVP8VMRNGL/KQAVcDzR6CzGYZf6c80bCUP5jdkTwl8Sozrpz1aOogxMg
	 OjSVmzxjry5xw==
Date: Tue, 4 Nov 2025 09:22:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Shen <sjg168@gmail.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	peter.shen@amd.com
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: aspeed: Add compatible for
 Facebook Anacapa BMC
Message-ID: <20251104-mellow-denim-dogfish-4affdb@kuoka>
References: <20251103093320.1392256-1-peter.shen@amd.com>
 <20251103093320.1392256-2-peter.shen@amd.com>
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
In-Reply-To: <20251103093320.1392256-2-peter.shen@amd.com>

On Mon, Nov 03, 2025 at 05:33:19PM +0800, Peter Shen wrote:
> This patch adds the compatible string for the Facebook Anacapa BMC
> which uses an Aspeed AST2600 SoC. This is required before adding
> the board's device tree source file.
> 
> Signed-off-by: Peter Shen <peter.shen@amd.com>

Still broken email/DCO chain. Run checkpatch BEFORE you send, not after.

Best regards,
Krzysztof


