Return-Path: <linux-aspeed+bounces-4603-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C24C55ABC
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Aug 2026 06:31:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDkFb29GYz2yMl;
	Tue, 04 Aug 2026 16:30:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785825059;
	cv=none; b=eiEXRhBxpqnNDcUe52uCzbFESL4fxs+3IdEqg+m/oLhFeoStqvuOqVP/h/0l4T5J3ZU4EauF152ZwtVkNxBQn+uKYPTmLLVrT2NSnGiLu1+KBqkA/NaMoiMiIsufXjf0I5rZl9jyoQclPfmdTD/T8JOEMzVtpLDt9oseVIM1vy5D7NYDV+6rByYkNV3T1kBn8W2M3qGN7R5OvYjs4AeVBEbQzdZKSh2LxmA844SnkFp1YlytoR/ucQSA5TLl8C98mns0RC5Ci2jBiuDtyG53FUg3sCSe8/nB4K+qwAtj1MM1KFLceFZMMe+cGLe4tmhAnZF+S4Y6Vl/MfZyZxc//ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785825059; c=relaxed/relaxed;
	bh=gi9d0l3rgCR+RUqTo7TMdUVuSdReZ3fEmqQNtlJwxzA=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=MgruE+7V3+LOVaNlvF5dGrDeyBIF3gTndPkqP/puCT/sdgxWuzGJIViyH1l+XrEibyK1zFuPwjG/Zwg/6NUV0iNo5fGTdImZLvAeIEQZzFjBQw1iRCu/FLfu+rsI1zNSEwGbHKi6PcA6N80eQkUGiL27pKUr8P5BlAk+Rq4ZwhWldEk5jNI0xNCu+na0LQhQjYwJmGFYQ0Xq9YFQOwzSf4Zj5hFM7kzsC2k6vNWpFhCiWlVtQnOOuIQHqAyO3ZPz2ZO3h7mHAYpiaPcBZsErTzHTS85cK8QzykcpxgXtV8Jl3IVE3s3Kj7QCOW6P+h0bqTMiTR+gBQNwGRZE86f99A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bO5aAQtk; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bO5aAQtk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDkFZ0TVYz2xpn
	for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Aug 2026 16:30:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1785825057;
	bh=gi9d0l3rgCR+RUqTo7TMdUVuSdReZ3fEmqQNtlJwxzA=;
	h=Subject:From:To:Cc:Date;
	b=bO5aAQtkO8KBjSXY3sQKjQsvvIPlcQi9EjRM33BJZ/FYZYbrvwA2HU77tMNG9Tb4Q
	 0jcATX+R9Kwvu1y07YpMt/7HHYAFPDHph3DHWaVqSoD0few94ATqaY1aU2hdnUN7Z7
	 iyjB/b4aq6YpC1pWNk5clF/tkwwyNPXi13oXEeIgNHFESD8gnps7UhbkAUfo6XZhfd
	 eEhJy28ZV4suEgL8XnddRO+3+fFpbLvSJj89JuFSnDDtYiUl/310Ge7Ik8FSDZ4dMZ
	 1MbW47E2HVwiLzPW9qClezNNWXBCXXmdS8osHqMf9UAmwEEI06IJc1wwh6TZ+sy3g2
	 48Z63TvNBIUhQ==
Received: from [IPv6:2405:6e00:242d:870e:1a3e:8259:e4fe:6a28] (unknown [120.20.146.186])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 60016655A9;
	Tue,  4 Aug 2026 14:30:56 +0800 (AWST)
Message-ID: <cc2b296319ac4b52602c891ab04807bd18a32bd1.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: Update MAINTAINERS for 7.3
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Tue, 04 Aug 2026 16:00:54 +0930
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

Hello SoC maintainers,

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482=
:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-7.3-maintainers-0

for you to fetch changes up to 6cdd8cbbf89611da6c948d58daed1c53f4bf8321:

  MAINTAINERS: add Ryan Chen and Billy Tsai as reviewer for ARM/ASPEED (202=
6-08-04 14:06:19 +0930)

----------------------------------------------------------------
aspeed: Update MAINTAINERS for 7.3

Add Ryan and Billy as reviewers for ASPEED SoC patches. I asked both to add
themselves to increase ASPEED's visibility of upstream changes.

----------------------------------------------------------------
Billy Tsai (1):
      MAINTAINERS: add Ryan Chen and Billy Tsai as reviewer for ARM/ASPEED

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

