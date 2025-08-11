Return-Path: <linux-aspeed+bounces-1939-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD536C87FD2
	for <linux-aspeed@archiver.kernel.org>; Mon, 11 Aug 2025 07:32:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c0mYZ0GvYz2xQt;
	Mon, 11 Aug 2025 17:32:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754897537;
	cv=none; b=h9l7gC0Yd31o524cWwkix3DRYf/wKPIXXwppgAfUKhfeMP2b8rD+3o8OWEfq/yVL6n00O8Z96bPCkhc0qkKcbrYtVBNrUACaoKnieLs5xGynLHl5q8UqRICZxxhYSiH6j9Sx2C77iVFKYoZMKBoqtpzolpBYWyN/iyG1ylFMC54ZWRGV9q/9AtRp1HYgI8mwX3+tuk5l2QzOzCecLwdDm0Y7NDIgSiB9cXPkZ3r9sqvoME6h611LaFN59kLz8g6s8/6PXoDCgLfYcWyzeebFwqXWUEe5IM8d8E+pQpUaY6T4VKLHTIc6Rm1DinnNjjiKYoaE9VlMjN4dTFLm9wt3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754897537; c=relaxed/relaxed;
	bh=VmAvaOe6j5EmRYWGU1fBubg+Cb6vql9Hba/ceuT9oGM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iy++zQ/u7g6mcXCv0uSQXHHaWcgPCEMtx6cwpEJGNpomFMlMWddK/fUxoyryOHdr/gcbMEWMUU+P3x807zPWbA77ArDJ7WzKOzYmWiaRp7wutFuS3ajJqyP1FC4WubKSFb5nTpN1f+BZBCSyM0zewcZ3gjT7JhMD3oaYkNcFYtNcSKfRIX37oF7uI6ARs1DpRfeQ/59nvLAP4PD4RXjBg9RLHoQBxdUVCu1d8WYSm6Y9qOTVSy1AfsacBB4zVE1sEI9RsPWSF1n0EeXSOl9wOZGlvleKW/1dYxAOkD1dRaTt1V6CXj5YxYO/VU+xFTrmYSMfQhzwrBYa79IhByInjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KE79nxKx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KE79nxKx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c0mYX31fdz2xK4
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Aug 2025 17:32:15 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-24003ed822cso23071945ad.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Aug 2025 00:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754897532; x=1755502332; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VmAvaOe6j5EmRYWGU1fBubg+Cb6vql9Hba/ceuT9oGM=;
        b=KE79nxKx1szFUuhA5lGzR6Do2TG3wrdAeG0k0bV04MhxyABqLFW3ZAWTjkWv6VFGdw
         FxY2qJU1LXATbAXjHlc2r1Fo9ClUxKNTqxb+BnFOkRWTInu2fjZl/R+14yCd3CUhZMRo
         Fk2yDWW+J0DRYKJtVsAXiExaKCwRi8zAuwlDISD+Zs/mAv/VZZbZoJKwPw4/xdg0Zhvf
         Hmk6lJYsxCPt8rCm906Jtg6j0cJhiCp/Yrqsd5PUSPaa2Y61qEwXKB/l3+eF0eNEhKuh
         KYhRdiqmT1Lb6ugw6oYlSD5MHMjPGz/SItIs5M/y9d8TO1P8Yi49GcUi9YLTfrybX47U
         7xYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754897532; x=1755502332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VmAvaOe6j5EmRYWGU1fBubg+Cb6vql9Hba/ceuT9oGM=;
        b=JfM9ap2TQAxwboWsqHENa3bhrcyiClep8iywD75m8sDZc+CIDS4/SBuNnfyzyUTAR4
         wz3e7SzDzGUcfWPA/5rkqvf5xQMvT8x4c45JTa0zqaC0Zck8vECKo/oWwIPbdKJGLFzj
         59/Sy6qzA7gc0EYyUGDgJO6Mu0RNrKMLV7sf8aXMsOqoptVEVlgNmnCQgsI2RXScLPUT
         XTETwE3nTpYcT1xAIxBZGjcxAcZ9YnEt120VUZeWa8tp9HSha9J+d10wdQ1yT44b5ngc
         ehEcQucPUc2AINfPvn0GNnk7jmxijGCySsMc/7lImwHWolTN5Wg3o4C+FRcqkkCXo+nU
         y48A==
X-Forwarded-Encrypted: i=1; AJvYcCUzv4QPdWjmrebpLvJA7qHy9BDSh88U+KhoOUlE2dsh1F9WU1llpIcDawWWET70BqJgS89Oy2ZRPL9b2QM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwJePT6eiyJ6OJ6QuYMi0eHCOCuMp/cCmG/teWFV13tnPI1I3r6
	azR6gax9tk3pBuWkmq2cHfANpSjueHEwdvhzxB8YnBBtDcQKSlT/kz3u
X-Gm-Gg: ASbGncuX2C7HxtiXiQhUP31IJZFiZHGQ4PgMZRopBMf8NXryJM8n3rHHkDzptpGZOjU
	pffYwATKXn+tP41Aq9fW17dKw210iGZwKU0m0sAaA3BQqJG0RRp7Nyknm2Wpt/qLwVzSQ2+Sojl
	1Ofyevevz6uTJ8D7d4VRpqfQRt0dE9SqrpVqOH7tAhKTwCRUxewMnm0Amlj7mzPgWB+cG2qhqLo
	wm4VU9B/JdOzCwXhXxnsFnQspP86zGaVOJsKhOk6Uy+6CFO0N9pa97HEu06ZfFB122Wx82IsycH
	hALO1gYxzmsQIAx9VbKKbm+wqNDykt+DijIsQBv/+x8TOinYsh5TmZhAIN7uTG70ouoyhma9ljR
	mVTU6BlL8cKS2Xu44jMNmM08pq7GDyBssgfTaeFVzQtzez8twtRjkvoq1j/LntcmCywPIsmuIQc
	X6F1nnLjjJJLU5pekoxkeShAcstLLE
X-Google-Smtp-Source: AGHT+IFXbN/ROk/rj/EE6wkBjU2Pa6lHobrT5on+fm9tiIBjWD7PK7FkSOu7E5PIF5JTYu2m2sIOTg==
X-Received: by 2002:a17:902:f78e:b0:240:1831:eede with SMTP id d9443c01a7336-242c21e043dmr224354695ad.32.1754897532487;
        Mon, 11 Aug 2025 00:32:12 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e388-d3b1-e90a-ba63-d547-4584.emome-ip6.hinet.net. [2001:b400:e388:d3b1:e90a:ba63:d547:4584])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef59b2sm267624575ad.7.2025.08.11.00.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:32:12 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Mon, 11 Aug 2025 15:32:05 +0800
Message-ID: <20250811073208.787063-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
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
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

commit-id: 2236141ed3d6f31f53147c26208dafef6051ae43

v1
  - Patch 0001 - add power monitor support
  - Patch 0002 - revise gpio name

Peter Yin (2):
  ARM: dts: aspeed: harma: add power monitor support
  ARM: dts: aspeed: harma: revise gpio name

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

-- 
2.25.1


