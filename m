Return-Path: <linux-aspeed+bounces-71-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557ADD111A3
	for <linux-aspeed@archiver.kernel.org>; Mon,  4 Nov 2024 04:14:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XhdQB2tRPz2xjQ;
	Mon,  4 Nov 2024 15:14:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730693650;
	cv=none; b=b+JBzD2hdtNrBi+w17+2Yrv3kFq1IEykHNvjoBGjxnMMmARehMGaGuOHoWXb5Afvun4M71NjCAZUG22ozqXDfnu9cjyeQ8rf94t+x1/duSR04dwt73zOJFdI3/QnlaDHe6TiFlJRvwCyE2u2chDAvTtKpI1Ib86FEo1Zj5IuDxSQr2qEDdBTuJ6rZGkC/ZNDI2YUsgJifkO/g1XGPBuJRzTzHSn3wNTpRaXodO/xj7NtTGTYn3OeDrldSLeJT76+L+KGKSXLXVh/zoFQ8ljDRuoI8W/ekD7uBSwWdJl6D1tuc3w1dc1/X4bvoyWHWxYR59OdUcSE1Nz6QkW9HU7qVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730693650; c=relaxed/relaxed;
	bh=UNSCjS1hoMEkhOA5T8UWRke7ikMlXHxI2Qlv0eAHNAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCs6/YL5Aja2kLFZAcJ+9gMkpO6UbzSC/EgEeEdLhZdVPZRnFR0n5JjDacCON5gsKVeBwY7crcgL0Ek8SARKOUrZjKRfITYi+O9BEmVzQzFzhJoZokeIEk37/y5JV6dvKrOyKSlazqnqyjt+SfFD0+FP07CbHXyhS6BlpM5gDnbqLUa4Hekd1JJu9WTCM/CpTgKqM9mtTPlhfy0ucOr1jEBjyQOltPJ4pv2qFnp+9w+0je6C31FRYqTF+cRY/Dd6IS6H1C4pHBOmWybDvMHXXB8F2TOoDi3WImY4qM3yibZ0lnZUA9+C/Flslioj7JgWjX0NoVwNEA3R8U2GwXnQuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sXdI98mi; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=andersson@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sXdI98mi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=andersson@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XhdQ83xdwz2xCj
	for <linux-aspeed@lists.ozlabs.org>; Mon,  4 Nov 2024 15:14:08 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 34046A41875;
	Mon,  4 Nov 2024 04:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BF6C4CED2;
	Mon,  4 Nov 2024 04:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730693640;
	bh=INpEY8wcvBsJ8Jx/Cwwyoxkp2XDOjLy6fxyDUa3jdTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXdI98midpimGyGBCzS9tIQIkeuxudwGFmriGX8YyhLArZErq6o153Py8D/un0txb
	 sc7bm5KuEPttghvVREjvaEKHWuCqG/fO0bryqp7Iv1T6o6LJFp2Ij3s/9HLhINHP0m
	 k6GHNmuwcUCuRv8qEZjkpWOA/uPjxEGeV3Kuyg288WEFpUXd4fqmKgjSmS5u5oIBtJ
	 BxPT5FAFZnsgIXG42L2YFjWTN9ElPXKZ61PRPibNORgE5m2KXfkEvoDbfkxsiNTh16
	 kBg38TMY4YaHdOvuTiOrCzOT0bDWBajk3jl5M2EQ4rLAAqelPc4TDfaXPV18BvUlUL
	 A7sDjNSrgLpgg==
From: Bjorn Andersson <andersson@kernel.org>
To: konradybcio@kernel.org,
	linux-arm-msm@vger.kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	linux-aspeed@lists.ozlabs.org,
	Zhang Zekun <zhangzekun11@huawei.com>
Cc: chenjun102@huawei.com
Subject: Re: (subset) [PATCH 0/4] Simplify code with dev_err_probe()
Date: Sun,  3 Nov 2024 22:13:46 -0600
Message-ID: <173069362370.23540.7771718939151529265.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240909122921.12627-1-zhangzekun11@huawei.com>
References: <20240909122921.12627-1-zhangzekun11@huawei.com>
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
Content-Transfer-Encoding: 8bit


On Mon, 09 Sep 2024 20:29:17 +0800, Zhang Zekun wrote:
> Use dev_err_probe() to simplify code, and we can avoid judging
> if the error code is not equal to -EPROBE_DEFER
> 
> Zhang Zekun (4):
>   soc: qcom: rpmh-rsc: Simplify code with dev_err_probe()
>   soc: aspeed: Simplify code with dev_err_probe()
>   soc: qcom: smem: Simplify code with dev_err_probe()
>   soc: qcom: smp2p: Simplify code with dev_err_probe()
> 
> [...]

Applied, thanks!

[1/4] soc: qcom: rpmh-rsc: Simplify code with dev_err_probe()
      commit: 454381b5236c22ff5995aab5db4f640d34f9ea98
[3/4] soc: qcom: smem: Simplify code with dev_err_probe()
      commit: 876b405004842b10a684f06f967502d20d64384f
[4/4] soc: qcom: smp2p: Simplify code with dev_err_probe()
      commit: cd8ec43758a5ca91c5503d1cde2df95e05b968ca

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

