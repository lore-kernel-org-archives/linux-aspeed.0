Return-Path: <linux-aspeed+bounces-3937-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187FAF8FA72
	for <linux-aspeed@archiver.kernel.org>; Tue, 21 Apr 2026 13:03:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0MxM40mGz2xd6;
	Tue, 21 Apr 2026 23:03:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776776631;
	cv=none; b=BQ+kXDKnCUEBDyays7a2aMI7Va0TIQ3/Nf1CSWuBcTTHLsY93fFYoRL9nTeHXpg9L85ZtI/pyGCyxRCCyNXjOH0BVYnciymYdHMo406RSQwalhZKwXEA+16gN67ogF3CEzS3vPtL0E5Djcs5jjTAu2PpDgs3zfj97vLXUXSghNdxp3j4QOFr05m8AXcIhQS01eGg0uJwRSOoqhTdXuSstfLnOJ1MajIbImqNWdDcEd9Kh+g0lzwpccVOIVkLoakWHAI9RoNsy4h5CFbTZxlTTxwblUP3tpQM+o9HmbDH0Icb9i+g54TeMsADzNGydl+bT/AQVfARpzflBbGooRRY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776776631; c=relaxed/relaxed;
	bh=ZpOX5RXqNUjplHgJxW+vYUkumMwwbJe5HfVnVND0CgQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ShNlVYcXQpDLR2D8IHjFna+vA/KuxguxRaJ2IltpkVNaYB/kI+TmGvobUOMsksZQbmztq2a5hulwmVoJwB5cMNnhVNqtwOPlwA+NAQwoUD2xKaMewGI3mcC+4lqVsIaj+l+5fTXmG+tZnBiMvkOTgSdGzl0pldpmPZhtbJ1cUXcYLgPMD9uBFnRchRMu4qphDq0046oQfmwZfpjvCQOYLzHrTHQomnJg+Z/lQxhAWzogn4FzbpTS7VMswk3qj8Fv6Z4nG8cCtq/yV04iUKoAyyrZhh7cCmeqN8jzXg5AIFT0fGmzh0aKvODuUHoLKT4khvGrBnYJ0QXZHP/ygHPXjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W2XEU+ym; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W2XEU+ym;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0MxL109pz2xQB
	for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Apr 2026 23:03:49 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso764493a12.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 21 Apr 2026 06:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776776628; x=1777381428; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpOX5RXqNUjplHgJxW+vYUkumMwwbJe5HfVnVND0CgQ=;
        b=W2XEU+ymz1kDpyACR/jrFB6JcqlDv+afY9qb3MUJryx63qpxze041sAPrQbVjiXsMb
         CSb4SQZQHrnYs1BLM/LbOWrlfRiaOJAHsSBiu2rS/SDksRDvs4OITAwmCIdvgsrPA1P5
         aOzUsllW+JbiZwmzh6/8Og0Z9GVPBCz+s8M0WYKaQR2thuft70ejtLSj/40c/C6yFte/
         LNoEoy2Hutte7UplIcvGCdDA9VlMvDBGMej3X6i7szxhgU2fwpeCEnHI7TYtlfqFkVJw
         O/NJc7svIKWn3CYQkzBX+cauOk9i4d9MRGHMcEQ1CXdwlbMrvH+TeEK2+mds2R9S+ViR
         tmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776776628; x=1777381428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpOX5RXqNUjplHgJxW+vYUkumMwwbJe5HfVnVND0CgQ=;
        b=DgsOnX+B5HsiTNDK0/AqIPAxQeawQ60JYjfazAejX608M14J3rcCO+Mj0/7niolyoc
         p2M3ES1YhklbqN7co/PAkVDulTKnqXOWxKnSBfxcwZuH05/xyBVCb9tCfzlgXavucQQb
         0VX2mY1KkhGDvO9kV28aB2FwYnufk5/s1IddfXVLZ3DP4KRcbb4vm7ov40hqH+NwxWEL
         AXU8Y/k78Mmp3/tj/5WT9OgiZCuMAHgJtavOKDH1NgVN9IpSHBg2tVo09ihP1AGaumyZ
         T5srGwtke/tUh67tFGyM8VWgRrWZNk2HT+NszYYyTWgLndZccjB1rd46vgMhvp3z1yVZ
         9Pig==
X-Forwarded-Encrypted: i=1; AFNElJ/Cj3J+qJtmQuC335BNu4Fq2L7YYyhqCyghiVeLBN5Ph3J0pvNctKbqSv54OswcjQmwU1f7+rAzn1KLgXs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyLKGTNvhwQzjXLdPdk/mnkxyF33VJ4v3erFQBDi3+StQUql8M6
	4LnkJrJ9WD51mt9L1ETqJCc8bjzXlPsMeWRPqyNwKCKi22tYqKyDaj2b
X-Gm-Gg: AeBDiesZkMYfNpM559yV75c4I3YQQ8wKSt0wnhOZ6HyHU1ibYclKyauzUj16NlqRbOp
	i2SRx41wyU0VoXFSNe1tGfrMhN9QGdSokEhYQbjyFtN3Oj1bVvXvc48oyvmktuL/b/HW6U05dxk
	NC0T+PxiS8eIBmEXYdhwSY24jnycxFkylO9Spjkj5TG1p4iYxNuTZHROXIe/5902cWOzrWlduFq
	L7pjDvnx8liFxZrXIKOBJvQQG1OhfIc0fvob57xdz+4M0aASsI4lCn8DLlTBe8HW40mxY1cisca
	4a3YwZBoK5su43QyRsGIsgA3WA+//MGog3ztO8O5g4zZPHSE5m5C2rU+Dq5fhFKoSuZhFNcq6gH
	fLP75hBsCaU4cRsOodj+4+t38XJYIl+NpNtNScH1O9kY1t3xskInhs0Lw93v/2axIe6ONr+w9jx
	gthO4zUlclNRVITrSgCg+lJOMLq3XOswY9mMYF5/BKhzfsB6iUSLtyzTOH8DoEtDqgdcUztGEsr
	DltgTYxU+nkA59BmCvIdgw=
X-Received: by 2002:a05:6a20:3c90:b0:39f:acae:f12e with SMTP id adf61e73a8af0-3a08d748ad4mr19977605637.22.1776776627679;
        Tue, 21 Apr 2026 06:03:47 -0700 (PDT)
Received: from fred-System-Product-Name (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981a0asm14456484b3a.3.2026.04.21.06.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:03:46 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1]  ARM: dts: aspeed: santabarbara: Add system monitoring GPIOs
Date: Tue, 21 Apr 2026 21:03:40 +0800
Message-ID: <20260421130344.2751662-1-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.52.0
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

Update Santabarbara Device Tree to include several GPIO expanders for
NIC, Switch, and system monitoring.

Changes in v2:
- Add system power fault alert and E1S GPIO expander interrupt
- Add switch board SKU IDs and power good monitoring
- Add NIC1-4 power good monitoring, reset control, and fault detection
- Update the commit message
- Link to v1: https://lore.kernel.org/all/20260129073749.3155383-1-fredchen.openbmc@gmail.com/

Fred Chen (1):
  ARM: dts: aspeed: santabarbara: Add system monitoring GPIOs

 .../aspeed-bmc-facebook-santabarbara.dts      | 125 +++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

-- 
2.52.0


