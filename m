Return-Path: <linux-aspeed+bounces-4923-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A650FC624D4
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:18:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0ZC3tKyz2y2J;
	Thu, 03 Sep 2026 10:18:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788380286;
	cv=none; b=eEUcjMn/jExQ9Kj2LCTtJ+5Nh5xpiKYZFNYIK8SnjkcKLrQ4RBlt/LCSAJ/W9uCfbDub5HSJpEjLwM6pColiAUWFw8RXlq+d0ZFLAYG97zKKMduimmCWttvnJxqclavSmfOk6bSH+VPJyN/ryRHh1+QgNVj+cQ8mZNtRPfuBa5ZJ/jnY4Q/yTt2im92ETlIHGBF3Ld67wiiQSe+Dcgb+Ty7dMTI4/MsVhpnYHE3Wl/bMmEY74PUJ7NVe0EEcymmtbO/wDH1wFnR0uUCW1XHu3vDw2BJJ0Sj6J4BEfu0hRrWKzwDWfvp4Bgx/2Ic+Xe/Dbvl2OHocOMKWZMQDn0oyMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788380286; c=relaxed/relaxed;
	bh=dWK2/qaA/kgie630momcYQ5e7QWvw3Fh0xiIUnGJB64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEtX2T8gPyuc45ho7Siv10ChqJhvhFzCOZ/xWrv/0LfgZfTwB1h3miltxVb5h13HlLdSC6GNBfQS8JvLa2aVJD/hodn5O9wBDedV6JEjV4AzmLfN+IXXXvcjF1Hk9pgsU7wTGKWp+ILVSrHAUza8icHLvlz7iHrLD38PstlOnm0S24M9H37v2URm5LLyZdlLXpzowBXobeCWf9bJhesSyOgpAv7Tkm7uZKQDWLFNkNS7LCxVzkyzbSrDvfPlczPg+VsH5dpRsJPOUGSDTO/I1gfD5eDuqZRaG6wEg/PWIVTjLdHo2QCPnywX4QJuUZ4bM/EsI/RKaKjmjaybeS/JgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DqM8xg8o; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LlP1jZ1K; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DqM8xg8o;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LlP1jZ1K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZvDY72Kxz2yjp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:18:03 +1000 (AEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KH9Ca2523712
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dWK2/qaA/kg
	ie630momcYQ5e7QWvw3Fh0xiIUnGJB64=; b=DqM8xg8oAo4+te9MVkPE+2hkAzc
	jz5r9PJt3nDNOGMwdU/VUpro8XOtp3eHfX/u8HVUvQbu0LWCEtcmP5SLJcrrGspl
	qazsvC3ud6osB0K9NzaAEcU1rjz6QqFJugx6i+mrKgjMZBnECm27NB35J2zRSf9S
	XRpbNtmaL3xkSniXibMGlZNpXp2wU9GMSD8oBDO+O6J/1a4xYS7frja/mRQD2adV
	vr8uhDaiq5bxg56VPEFx5qdC8a7xDrgaQ8Qq8lx3ghdriTlbu0dZFSnmhEbgKYmB
	ya0xA/vAO7hnVf9OUZWz3jWUwUoutjgPdxOR+DWuQPLCFALNsgr1aZPu3Iw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gepv5s4p0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:18:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398e1f7d1a5so2394027a91.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788380280; x=1788985080; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dWK2/qaA/kgie630momcYQ5e7QWvw3Fh0xiIUnGJB64=;
        b=LlP1jZ1Kxd0lfGqNrKJFc+O0y9/0a31IynrCm0sGW5tXQqnpwnFnIWyDdkP0aePhw3
         UdC5z9UU+IGvoQgFqfzwk5tuPcbTcyCy7KYfLIxx7WUZQVR964Hh3l17NZf/ybjCXoc9
         cllZoAaqYmzf9K4t7l5XZqQcnvPd5JyApyB9EdRWW9s9AM4mnw+pJC/BIVQyHN5xHHpf
         IdD1FktPQb8UscfeXcQ911myf3iE9Sx/ghdAolmpA4a7YTOcoNcnL7msOfcGW/Sd8j4O
         5LzpXzTbH7XDSc8fna+80Nu6FKryVYg55cKIriBjoLffoelAV+QPnsTYO/FTLws69M0m
         7bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380280; x=1788985080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dWK2/qaA/kgie630momcYQ5e7QWvw3Fh0xiIUnGJB64=;
        b=p5oKpzsgJjxez5kwhadavejZlbbXqjmPAGWuMOI0huuZDpsZTTZkzLXC7tOPTpc8Bg
         3x4TcOgMvg28V0Cj01wlIOEzDTH7z59ZY0l53Y3ZqurFdp23zZGw6WuC5g56m2xF9bGj
         QsaukmZxNDec7TQsqYEyD/OrjMOpIiDwOAKcWXxQaGJa3WWrhatZIyqoLAtrlFMGraPV
         lRiDMxqF3hYicj6q2NLKNIk/AtxCj72l1dXortNcZmMIpeyu3wS7vtApM2z7xfwsjoXE
         pGUrsJOa1PyA1HOcs36c7AMxX/55YqGNK/zFgyHCSIp/sW7Vvw3CcQwN8U4I26yoI6LR
         XAww==
X-Forwarded-Encrypted: i=1; AKwUvByCWEGBDYxDdQuXOtawnq5zGkIpXZmM71okOkFtx4EzpYQamj1QfREXEv02IHx40IDdTVOkqXPZleuSEio=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kLX2slQHXS3e5aaZ9F2pPJcWMB3RdlZF2W3w2ZNWSbuW5qzpa9
	uYxSl+9grJmjHbHZnkT1RF9jKrtF3aKqwwpdlhrpqXmYF0gwE7t1FifOJypihrw7Be14UmqHXkP
	6fHWePv79vMDUF1EgwCfYHmihnKjQS3Gz49vYKbVmI9S02esnSFCutbdqGBNBdFh70TtC
X-Gm-Gg: AYBFou2FZXe3FdfBjcypLB+LwSG3GH/wpu5dve17DCwh2zaYBkzCEsf/kk4YcYkSj7i
	QPJvMSc6W8oDIsjAGwgzWUU91G3Qh0pM6ccry3lF4iXkjJCS7dP8RsSLLHw3GYl+RCd8blvTs+7
	Re8jG2eG4Zk0XoPx2IrBqs8U8tup9zhKP1IISjhV5xqvrlnMWqNCkv96BSIZ4XeLpPVMeTsqh3L
	vVGeNFVEBKmGPOo8wSd19aBWCKd9Jg8Jj5JZi8YkpSS2J0prmI+9kKapM6n0/zJD10OG+DuKSkH
	m/kap0IkgcXxCFFkoTwpwzszRAodRZLy639Rvg1HtxWweH+A6U/uifdZJBR0wQYpD4tfVWezEzB
	Lvnx65Z+IziYqRQQepMd8er8Xc10=
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id 98e67ed59e1d1-39aee1f9788mr12319151a91.24.1788380279853;
        Wed, 02 Sep 2026 13:17:59 -0700 (PDT)
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id 98e67ed59e1d1-39aee1f9788mr12319070a91.24.1788380279338;
        Wed, 02 Sep 2026 13:17:59 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:17:58 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Paul Cercueil <paul@crapouillou.net>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Paul Kocialkowski <paulk@sys-base.io>,
        Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Michal Simek <michal.simek@amd.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 8/11] drm: sun4i: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:37 +0530
Message-ID: <20260902201640.2024648-9-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=T8y8ifKQ c=1 sm=1 tr=0 ts=6a988479 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=UuaWy5wPpgFSIu4BNl0A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: qQrYlrmUMNhe-O6fWSktUjEQzjFV56Fq
X-Proofpoint-ORIG-GUID: qQrYlrmUMNhe-O6fWSktUjEQzjFV56Fq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXz7uceVF6vUNg
 EuqfmdwhkF4G7nk8+DLYPPePBC/rHK5cJBVz8InwShp8/hcfUQ2mkX16mhXctyCh6kZ1GlL5Ivj
 ThdaFT9XrzRj3sYOUgAOQdsw59Po+gO1MsUCbvoCKzKoe2Rf3vL01M9F9moVe25GIudDVT9Mma8
 NQKS4hvtB6C6lHViux4loegxyj5LXCFgdI0yPbTalgSfztQdffM4INMZZBLg4hLKzdbVrEWFZBb
 hc0BZMoN9UMpr/e8v26lhbDbasqiOqnk/IV6rwqoaO1fY3CWat2DbhWolC5RReTSUgNQLbneWoG
 8yUlrX7pZDVtV7EU2VnZ5NGy0Fm+/GR00+07SpXZImeylrl6PyTqyBjnBXuE2b2RUHwGCNguOkQ
 x/NfrdrhCh4w07o0YoU76UuUB+4djM99SY6Y5X26oDdmT9sDxxZPpPSHvSEm3qqu8zWOHUHaT+J
 kH/ohSzwKylznFoFt3w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX2S7yHNe8LOa8
 9+lNNUErhdoM/jsKlqcJtjh1RLpWlYd+jXnnRKH2SOa2amy/SK0xA6UT64FWbI94rpu5tFRti7G
 /pGebXrLGAUmw18qwqawl0JztGSPlQE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020179

Use the devres-managed devm_of_reserved_mem_device_init() instead of
the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
pair, letting the device resource manager handle cleanup automatically.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index e9baca360160..c24f96bdd135 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -80,7 +80,7 @@ static int sun4i_drv_bind(struct device *dev)
 	INIT_LIST_HEAD(&drv->engine_list);
 	INIT_LIST_HEAD(&drv->tcon_list);
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret && ret != -ENODEV) {
 		dev_err(drm->dev, "Couldn't claim our memory region\n");
 		goto free_drm;
@@ -125,7 +125,6 @@ static int sun4i_drv_bind(struct device *dev)
 	component_unbind_all(dev, NULL);
 cleanup_mode_config:
 	drm_mode_config_cleanup(drm);
-	of_reserved_mem_device_release(dev);
 free_drm:
 	drm_dev_put(drm);
 	return ret;
@@ -142,7 +141,6 @@ static void sun4i_drv_unbind(struct device *dev)
 	drm_mode_config_cleanup(drm);
 
 	component_unbind_all(dev, NULL);
-	of_reserved_mem_device_release(dev);
 
 	drm_dev_put(drm);
 }
-- 
2.55.0


