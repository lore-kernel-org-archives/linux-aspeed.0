Return-Path: <linux-aspeed+bounces-4756-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770E5C5DF6D
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Aug 2026 12:26:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ5R134NTz2yRc;
	Wed, 19 Aug 2026 22:26:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787142397;
	cv=none; b=XSwtOHgmdKk1KF/6iu8TJM/yYm2ud4Cb947QwMX1yOsMMncjpNvtSLgrnzIvn/2JAdTLpg0rK4G1cogH/EHrMA7lTSuzQIBIkEe9abQUkTxGZldTmWN6f3Hs87T6o7Vr7Ao2Ve4RgYFrPF5RhV4FFEFe/keaWba8zrqRFH5fFOpom+avS4Ot7TjQars56osFqydMzlpW1GAA0ps8tFeaiz+SFWIX4u5fQg0A7aGe9d1820UPF1YDfYz0yRDrgEdIPC/WErErdUtQaXkbvIkwY1Iy9CULnXyomRVy6Dup066AcbKzu2nTMn40Hs3j1GTy/E+pZKW/T7prmGxQGmE8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787142397; c=relaxed/relaxed;
	bh=n4bneSW6aECyVz1OzLnV9TznkgVy3jr04x3jXXFFCXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DdrUcE3jojAt9yloXhJzM09CzgMizgFBONRAUw9dfClPMwZpmaGebGbxIpUOE5aA140LFnelI6ptpnsxd66yzZxz1Wt9ATyvSTl3ruV2Of0DzeW/uq+I5GetP/dflpgMJZcyzGQoQsLGx1wpTVbZJulkopiHv3rt2CUgF3gldh1TZ6TsdqJaNJiHqCzIdXCNx2nnv2RAukf1rkgyUtMtq1VYOpZCE1tpY7C2mwQYmaIpMBqrv7+ObCHlGJs1oqDINlWfAOb8EKHrXXfD6y1OhmmI3tXtCn9q1oVKtBwXAOJes91r9M338Qfcopcp7LILpbg94a1an00j3D7wWuTyVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=YRTro1XN; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=YRTro1XN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQ5Qz08vhz2yRZ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Aug 2026 22:26:34 +1000 (AEST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4980dc26022so10189745e9.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Aug 2026 05:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787142386; x=1787747186; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n4bneSW6aECyVz1OzLnV9TznkgVy3jr04x3jXXFFCXw=;
        b=YRTro1XNEHzlSXmpRB2RM5aDODkYV98ireE9W5tmbSOOALQvhKp1FRZN5OZPVj8HE+
         Np3L5CCqgowUB4BMwhX/rLozKVacEXSaUP8sECA1Y4eRiuspP39prp6O5Xl5TOX4nKxM
         ptlrD1jSxJIqHi13ZNY2ASbDHBpZbWwC/gmPLm55GnEgCGYltLJyD7918B+HZ/5cwDkf
         IZfldbSuljgMSU3F1pABCpJErDRQgodrHTaUyIEzYhwa/t0iz8vBtO5waiG3Y2Oy7XPN
         ZN56MKpXvg1/48Wxz/KNZ2TESmIDtOksT4Gn3U4LVJKSAew/ZJz9sEL9fERJG+xWysEl
         5aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787142386; x=1787747186;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n4bneSW6aECyVz1OzLnV9TznkgVy3jr04x3jXXFFCXw=;
        b=kKJVrszjYa9eFtJhU6LyhihnbyWPB+worOf8eLAt2Zbt5dJl6HPBPqt19djZhSu04y
         3amrfHEvrmM0qz1B0qXzXJdTLx2DArWMbHImWVey9iDU/Tp2KZSezol5SuLyVTsnwNPv
         O/hRcXtwzs7yQyjJKY/U1WXuBG5k4d9VHWmuOaUxq1IsOutYAxJasMD1crxhFOfElrqx
         +dz7U0QbaRBNMB0pobDtvyYCifxftmPlUqgOuTdOjLyexjN33tLcdHX0pdmaUPasC9B0
         7MLq2ORH8zPklyLt3QRm6b2N0Fdc5GEDd6XFkALJs6T5+bYP51LZMXX3edeocCspRa0W
         x9Nw==
X-Forwarded-Encrypted: i=1; AHgh+RqIABJSc+PhADGub2XXPi8mBx7JkwG/d0nKGsNZwFvVyTWiQqf1X47cAAFgQz5+KmyAmiFXcXTZ/kg3kX4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxEs5JtKV1wZ4/MX3y8hWNKYtYE2hpUWD/J+IhJ7w6x2Scy2aiE
	2p/BIIV0oY+JcBe331uv7SLMafZygN298GeqjPlq7ABscau0uhuUBkJ+YfKFz30iBx2l0BZoTxN
	9KhWYQ+0=
X-Gm-Gg: AR+sD13UqKl/cmNkvU4ukEDv5/ptPPzZmnxz/cimkH7u6zCShN1lPhUQfbPvILwUWpB
	1KDvFcBd1JVyuLBfZnmBk6WrzcU77Xs068hgJVLMXzyijVrnZQsMxBLvnchkVrD7OJF724KAd3l
	kbJjPyuTHa1Rl4qf2IdV85hil8RFJmoVFsWCdrjsbqEInMnxNAdvz9rmi4/gQNTWztMtlgl6Cvm
	X4LDSXV4fIX8l2F9Z+lvD7RbaIIVAWqCkX14uZBlpq7okOVMD4t1HquS0eQzMER/fG3ZRO0dR5U
	fsZM5qkwlAdpQ9XOQsSCD2za++lDIpLMjO9XPjO8tzIZH/TdQVhi8olFDxB6eV/dCATFWj7IsSh
	9CwkSYfXxzBmiXu29CxS1ntfpWvfcZ4dIFWQMRq3DJh1wn1NBkOZMN6UnlZxemgRoWKfbYf/9tD
	WOh7cJnj8bx874mrvT2FQ4hqErtPH7dZ60kdS9XcnqN6Xv5tB+2GETE5IUdGanLLP6bZjU
X-Received: by 2002:a05:600c:628c:b0:499:516b:83d5 with SMTP id 5b1f17b1804b1-499aa1dddc2mr84096355e9.11.1787142386083;
        Wed, 19 Aug 2026 05:26:26 -0700 (PDT)
Received: from [10.0.5.39] ([2a01:599:445:d261:4474:9672:b73d:5481])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9e09e87sm36477865e9.4.2026.08.19.05.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 05:26:25 -0700 (PDT)
From: Tan Siewert <tan.siewert@9elements.com>
Date: Wed, 19 Aug 2026 14:26:12 +0200
Subject: [PATCH] MAINTAINERS: add Tan Siewert as reviewer for ARM/ASPEED
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
Message-Id: <20260819-aspeed-reviewer-myself-v1-1-bec3874cfcd7@9elements.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQ6CMBCE4auQfXYTCsRQr2J8gHYKSxBJF0VDu
 LtFH79k5t9IEQVKl2yjiJeoPKYEc8rI9c3UgcUnU5EX57w2NTc6A56PLVZEvn8UY2DvfGuDrSp
 bGkrnOSLI+xe+3v7WZzvALUeN9v0LWEoS13oAAAA=
X-Change-ID: 20260818-aspeed-reviewer-myself-dcdb9f944931
To: Andrew Jeffrey <andrew@codeconstruct.com.au>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Tan Siewert <tan.siewert@9elements.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787142385; l=882;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=zzftI5v6XOEFfKEIga1QUISGLsz0X9FflOnPLA20FVU=;
 b=rX3BWKVv1GRhRC13EfmK8+SZTvgMEWEpwIxVKV/tX3bkh67365ZiRDqqeyl01xIRJUS8Tk6iw
 Ay7X2qWmCY5BnoAVnqwL9I1Z9DiLKr8ZdZgbkoOm87d++x8AVgQjwgh
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

I'm volunteering to help review patches for the ASPEED SoC support.

Signed-off-by: Tan Siewert <tan.siewert@9elements.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b7094a616afd..f153f6d8ab0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2678,6 +2678,7 @@ M:	Joel Stanley <joel@jms.id.au>
 M:	Andrew Jeffery <andrew@codeconstruct.com.au>
 R:	Ryan Chen <ryan_chen@aspeedtech.com>
 R:	Billy Tsai <billy_tsai@aspeedtech.com>
+R:	Tan Siewert <tan.siewert@9elements.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported

---
base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
change-id: 20260818-aspeed-reviewer-myself-dcdb9f944931

Best regards,
--  
Tan Siewert <tan.siewert@9elements.com>


