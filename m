Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8633606A31C
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Nov 2026 03:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxrLKowy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQjl00CnGz30MZ;
	Fri, 13 Nov 2026 14:42:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794541371;
	cv=none; b=aOHQRgO3wH6T1J7hmm/cCsYT5PcROVZ9rHXt+yAE8svmyMQ6R18skF5BpiYJjk7UdU6V7flCINB3ramFmvPa7eWl6hjQcL2W4q99tWozd07Hj8/Xw/bdCwAqruxn3rA3OYW5gdsMkqGxD/64jkjDAq7tbrGI6+9FAh9OLXONFu8fplsj9HwhjBxSs2Ihtl690ypy0qapQb34YmfDp0b+rR8IlNmH0hjXoRjPI4mCvUYDVa33JBmRmbeJuXFzklMpOkvD1h+vvpdtyL8kJMIQibtZb+7RuSNXCFvKoQ7uZLzlJDil9EYs6dBV8qjM4yv9zlyj9tva7GDnuLxW3BhBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794541371; c=relaxed/relaxed;
	bh=7wqtaClkA87RYbtDZICJouKtI7I+Hc/L5x4RkEdLrEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5dcnG1UfwF1erEpeP48mrBt/YOC0iEvAoVtbiJSUnx1ZgmDCdLuw15GQr4BKx4Kd3vamXZZT2WWMDNOeUmlCBfgyJeeYfsc2OCEqJrh8iWnPwvrIRjQ8DXh6rritlnmWmL9caD/n20MER51eow9VUUSPAmzgj93dEU05OD5vS5sqETVJLaAjsjAsAVV6Cc7R+FLhCta3EA5tov+UrJSCgzHOpMjCcCghQECo14PcZwPVZIDkKmM30u2TVjGw0B7rnbniPeZmgocfpJPQSBMINfhS4k4DOeAlj+siIor8+uFB3m38BQU7FtOwUGSJSz3WBK9T8jhuUZqcSvKsOhYjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxrLKowy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxrLKowy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQjky5ZGRz30C6
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Nov 2026 14:42:49 +1100 (AEDT)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so1106518eec.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Nov 2026 19:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794541367; x=1795146167; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7wqtaClkA87RYbtDZICJouKtI7I+Hc/L5x4RkEdLrEQ=;
        b=XxrLKowyUaKA7ImCft8qng3m6mt3iAyAJyZJJzndteDe1WN/QkjNySWUwGH1X3YPL9
         PoE6ZP65dy/k7G2v8n9+Kpy5DXB3/+zYv1rFpHzAbpgLhB1tDApyAcKEHfyVqIYSgD7U
         ASaIfKbkTLsWtHyKtcvQxYqv3eVlGD1swvU/OwaliEfTC/wi6xbZj10kEAPXbydHctqz
         UrswD39JgwAw4hkfIXAmTbtnHpEcvtjMahGv6aKa6keF7aqsbqKleARECQK+/vKZdimQ
         miFASm7TEy6iEK9bo6oBm7F5egtDzf2sJ2i7WTgClmFePtLg+JZ3YL+n7JpCvGH9se3C
         MiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794541367; x=1795146167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7wqtaClkA87RYbtDZICJouKtI7I+Hc/L5x4RkEdLrEQ=;
        b=ErunCTM/62U13FBmaDkKf2lQ5Xg2cuwYvOPzk0x7KRQ6FfyZGh2G4Gpqe1gStq7F86
         tzg+Iu7E6xnB8Fw3q/iPGLDLuLAkCei1HoNvLxafWa8826RGEPunfBR1eFKhCCPD1pWe
         ecBHNaAwx+cEL3U4FYh+0oXMPz8OptlEsWlHPnqjpvtg7QSFy5Nr3V4ZF39X4TASldz6
         S1Jy1sMI/aiLSQpq2GES9g2nVzgdzrlSW6ZTunnLJARsjrLxoZp84PLFTt/BJ4Um+Apa
         ldwHHwyVaqABfK2hty3zRRJjI6lWRnJ+7EUav1YvTYTdXaYK5wrorE2uTLuYMuWvVxC9
         ATPw==
X-Forwarded-Encrypted: i=1; AL+hErHtQnzFhJnZahzJh09GqX1xIDmXvh2/m1sURBqOfkVFLKXATFJuWRLeCm2U5tcYeZ96A0loe+e6PZYhxyc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9YtIYtwiXCsi2fPqnrQXRBPif4CCAr+Um/yF1TpIwcupDrcB0A
	UAMN0CUNx9NC4OFFN6gONvQ9PqeHt0G9ztL6N4nFYKbpZAYUE5M6OOHn
X-Gm-Gg: AYBFou1ojojriUMdyjn/IXRQkEmfdjUh+lGpGl34P4hNjEzSHkF58xY4Kli4mzFhabc
	VfSGXP2/WJ0hC3ql3dOU7SlCY7FZvxFwglnR5Y35Jb/XBFFz+iIvYjjJ2mYX0JvPMFQ9JA0CEuh
	AfAEj62x+Twe+gtfCQm3xqxExqfhcE0tFcsgo0Zt4HplPNnSBqWpWWhad4eeLd94QtVaR8+WukZ
	ncbRjDwnepZgy56v/RwJshn8jcwTF0IB3g+I1ki64NMsaMY+qMckWxVNwM5Gu9WwWKzmMTp8elE
	AUCIibJ8i29eWTMHyk4geQo4K4vbNwB4V4YejUFY8llJSYSNizL7EyNfMbtjBKE9D/TeHRgnT7z
	Bst7Kgpb5eLlx1ZHTqy2ESutJhAe04Fund7puah6iVe4YVZadPfgZA0UlF9a1bKqliOJJSeg/Yu
	zIFnwCoEu5344EWsW7/AOt8IF5lKIgINmRJGgzdIcZhU5kltjf/CK50E5ELf1k8++i6aov0L0B0
	/WRLA12Jtb6a5jggsJXerv713J19QdANJnsPO4+u1g34GWHAv1kP7Bvu7hdV8Ghh9N2IIwoLibf
	0wttJDbdZD4lhEtPtHUc69afubaJCQxVwPD3OTf6muVy
X-Received: by 2002:a05:7301:540d:b0:36f:4d62:2884 with SMTP id 5a478bee46e88-3796721cfcdmr1081571eec.30.1794541367340;
        Thu, 12 Nov 2026 19:42:47 -0800 (PST)
Received: from debian.prasanth ([114.79.136.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955e0d966sm2999565eec.15.2026.11.12.19.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 19:42:46 -0800 (PST)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: srini@kernel.org
Cc: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	neal_liu@aspeedtech.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v1 0/1] nvmem: aspeed: Add read-only AST2600 OTP support
Date: Fri, 13 Nov 2026 09:12:12 +0530
Message-ID: <20261113034213.158390-1-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a root-only, read-only NVMEM provider for AST2600 OTP, with serialized
controller access, bounded polling and configured secure-prefix checks.
The driver adapts ASPEED's downstream read sequence and preserves its
attribution.

Tested on ASRock Rack B650D4U (AST2600 A3), OpenBMC Linux 6.18.24:
- Repeated, paired and cross-pair reads matched.
- Four concurrent readers completed 40 matching reads.
- Bytes 8172..8183 matched a separate vendor-derived reader.
- Synthetic pre-MMIO timeout, failure latching and rebind recovery passed.

Host fault-injection tests also passed all 42 polling-timeout cases using
simulated registers and virtual time.

Prasanth Kumar Padarthi (1):
  nvmem: aspeed: Add read-only AST2600 OTP support

 MAINTAINERS                 |   1 +
 drivers/nvmem/Kconfig       |  12 ++
 drivers/nvmem/Makefile      |   1 +
 drivers/nvmem/ast2600-otp.c | 259 ++++++++++++++++++++++++++++++++++++
 4 files changed, 273 insertions(+)
 create mode 100644 drivers/nvmem/ast2600-otp.c

