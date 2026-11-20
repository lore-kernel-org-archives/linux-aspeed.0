Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ADD60A2602
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Nov 2026 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wDiP4BuY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWN6S2JRjz2xqJ;
	Sat, 21 Nov 2026 04:45:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795196752;
	cv=none; b=JXgTtkYendeyahmc76Plr+GToFkIbD7HcGNJ5rNbcYuszYybEc1RKwLbcrBWKMxpXDAIMev2y2n4E6lGEK3IdDSxNMGctOG0iHV5J94qZbT5DBLgx9Lw86OADmJoj7tqiUkDpvGF1q+qdWWveH5mwRntd18Kq2y5UgdsdD1Cl4Lyil3vhbP0s7rX9NG7BwrJihjHaVvIlvJmY/TjI1159GV1M4e9vUdtc5ENW/whuOltIA4MD3URKYMEKWPyHxzoNDEJ4ZFRCEDR4UCZmR6kbqODUzlEbtaDsJLw7zD34au3BT3pB7g0T65/5l4xbNygLEfI4R/DXwe+inPGQSrmrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795196752; c=relaxed/relaxed;
	bh=aLqQKB4BJytG6FOI8SN765Q87Olbs6zTh7UfW+Lz9ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5JRY3B6apKNQoFa1sGKNjHVbCR954VDNBfWAbfmKvx79f62kUdDV9B9T7ZRICKhV0dwSi4NpMv3lM049Zt0R6yNYx0nIHDDfpfoBIk3aNVBQoLNjxK/irrlv5mDTlHNvzWqyqJouSFpN2ADDoaqGC0IN0IPWrVTVwXr8QAAk0PCc8rHSSFP8zKWIVoz8CdZ8xWxlxw7nS/e1vHGSKuYe3mWUX26w4iw5Iw1bq2QnfVHan+qfCHXmrbxojCa18jSxrvciXAE03BS0Uv1b5kMHHHKG3omAxESkBl9pIq9DefdmumQzo2Ch2svuUQHVpAr5gIrgd8ShWlyR519tSdEAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wDiP4BuY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wDiP4BuY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWN6R3XT2z2xpt
	for <linux-aspeed@lists.ozlabs.org>; Sat, 21 Nov 2026 04:45:50 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-3b40470fdd8so609525a91.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Nov 2026 09:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795196748; x=1795801548; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aLqQKB4BJytG6FOI8SN765Q87Olbs6zTh7UfW+Lz9ZU=;
        b=wDiP4BuYTA+uyIo6LDrCM+J/cdv9HE7tWQ7yazJFKIB9ooDCOgvGdJ39Cs38sIuVim
         Q1/TwS9KeSH8VP7NgxvpMQSSxxrhXrLkQrrKH+rXLciqsFSD1xeaS8MsUCCI7W2pb02y
         +sBLNTb4Xle5N41acYVaWvVvnSN4Wm3O64z6sNWlcj84Z2Okxi0EK6uTLnoMoYG14lEW
         7lxopZayHlVWFM0PovcJ90qDWJasfkUgPb12vxzKXlnO+tTS5Ja6pxknMv4y6r8rW7Wn
         ElcDZrrcYsXQYciLA7oe4cA0NLdBXOl6Ar+ZmFSH8u5dIw5fCYLGAsyBzoTlSN5+CgFY
         Uckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795196748; x=1795801548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aLqQKB4BJytG6FOI8SN765Q87Olbs6zTh7UfW+Lz9ZU=;
        b=bJuvCmU0/t7vHsWRYPDOox5t5ML6EqNRhqxPPysAUJaLBsT3a+ZlXBcJNS2eRye3CL
         z4cXhp1QCKhrtCmqdazTavBXWn3IWodqyj+ts8O+8PoIv7uoD66q1iryRGrk0kYQA8Nu
         8VSYhRqCQyg9yGYYb9tJqH0ibjLSuto+pIh+HDLBpP6Ddxqu4klF3hC7WUfgc8aTohg8
         xHhGChrxj5QiU7d6DsYZc/RJR9FEB5puEQdtJOqnnEh4Ruqw4rHrUGJ3mz4mhtd6aCDB
         h58d/Gwft2l3UQb4aaCN1/2BMKCGmp+2+wVVgy9I986lyE3k8S9pxMtWUZcsOfqFY6hH
         vihg==
X-Forwarded-Encrypted: i=1; AL+hErFfNXtnk0V/bGGATrlPHJV4Tbst8440VX9ccTdP3I3fecX2R3K+58odBlM+uGCMVwOEYnCfWDZmmHrnnu8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z91FK8PHu2e4z40S0W2RyKv9njWvpDTWkjZ72f/+YHqoG4+MV1e
	9qZOU6KheFFtYYagACCkpP9Vbyp+Kh1JxKGl6eBULCc6a8/TvVLklqcA
X-Gm-Gg: AZFdTZe3KT02I1OYRa9Z/pGdfWtjXKgo6ASrcFGcfvHi0OiGPCk9jHh4noEMlmiiACE
	1l/OkhkDeXWo1KOtdjpmR+iqZVH5ZTZrrasFIJ6oxJfT5PUElHwXrGasGDN+3OvSJLvLLvU/Eo5
	Fw72qONozMBKfqIcROUvbNUtyfIIL6B8HmZ7SEwT/0qGBgjqCxd8VwCMOAaFQdn5uiF+ik/dz4T
	52Sq4a5zVqspsAYqr7BASIxkJ3O3hffyiz5z20XB0AUwoVQFLzHf4C3cSRxCVUqJ7QPHtq+IbVE
	swVim0arRWCcNNaSQndZn78e7HkASeuC9hTthiHWkxdG4AaISD3tXByMhTYsv7qkt2c+7y5+x4V
	t3rU/1W/C4ODPexH4cumuOe7u08fdiKGYO16WRJRkI7WTZnfpV4yGp6uBgS0OjVlP7eg7rWbx7A
	OM35br6wtqk0aIpSX5gUADbkCs5ujwosSRPH+WkNhcIuajyPFwdTQDffopQGk8rQs1zWTub/sKa
	/JfDiRAfSHIg03ioymPs2/j/BH0tk6CL21h420BVR/rGxdML0IfkUcsiWWvlLhRnUsGPxJ3CPu/
	TISdaghCLcb/OWGzfFaaXKKeHUHzRCnrWtvaZng/7JqP95Q=
X-Received: by 2002:a17:90b:3e81:b0:3b3:fd13:683d with SMTP id 98e67ed59e1d1-3b41cb1bc6dmr2684467a91.55.1795196748255;
        Fri, 20 Nov 2026 09:45:48 -0800 (PST)
Received: from debian.prasanth ([103.177.82.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b703530sm58052a91.1.2026.11.20.09.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:45:47 -0800 (PST)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: srini@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	neal_liu@aspeedtech.com,
	tan.siewert@9elements.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v2 0/2] nvmem: aspeed: Add read-only AST2600 OTP support
Date: Fri, 20 Nov 2026 23:14:38 +0530
Message-ID: <20261120174440.123487-1-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113034213.158390-1-prasanth.padarthi10@gmail.com>
References: <20261113034213.158390-1-prasanth.padarthi10@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series exposes permitted AST2600 OTP data through root-only NVMEM
for userspace diagnostics using raw offsets. It adds the SBC NVMEM
binding and a read-only driver adapted from ASPEED's downstream driver.

Changes since v1:
- Add the separate binding patch and rename the driver nvmem-aspeed-otp.
- Poll once after a 1-us delay; retain the 100-ms timeout and log failures.
- Initialize read mode once at probe and stop commands after a timeout.
- Use a fixed secure-prefix keepout and check the live SEC54 range on reads.
- Simplify copying, locking, configuration and Kconfig help.

Tested on B650D4U (AST2600 A3), OpenBMC Linux 6.18.24 and upstream-based
Linux 7.4-rc1: repeated reads, cross-pair reads and 40 reads from four
concurrent readers passed. A 12-byte range matched the saved ASPEED-derived
reference fingerprint. The 7.4-rc1 RAM boot used the working OpenBMC DTB
and initramfs and also passed the final-pair comparison. ARM zImage built
successfully.

AI assisted with driver revisions, validation tooling and patch text,
using the downstream code, review comments and Neal's hardware guidance.
Hardware tests were run by the submitter.

Prasanth Kumar Padarthi (2):
  dt-bindings: arm: aspeed: sbc: Describe OTP NVMEM provider
  nvmem: aspeed: Add read-only AST2600 OTP support

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

