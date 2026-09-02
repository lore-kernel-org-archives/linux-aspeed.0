Return-Path: <linux-aspeed+bounces-4931-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D34C624D4
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:20:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0bs4G0Jz2y2M;
	Thu, 03 Sep 2026 10:20:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788379657;
	cv=none; b=khuD7fteyJ3A2fqRwiTNZ9FRyY9/c1zyBBgGAA2vrqm6SY/Qlmu63wFb6mGB37en5fOLOB8+aMC/OXB7I3B2Q6NWucFJtdHl8xOqISbOJCadgpCd8EH8es3glSVUXqNc4mPyCimNJ/CqZagmYuihAfVBQF/GIAbS3aAPRqceMtApm6BWwVYGy+IsqIUuye/us/oRAZ8kG1IW3Ve3DXXxA+tVZrP2CsbRFbusva9POV00nr4/iMENgFSSYP9gvE4dzhYGIXpFBnGCHMx4OpdKr4IXZH2j+3tbFF974hEPREpVdL1RVa9f3xLfEoBceRkqfaqxlmfyECG95lUyb4aaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788379657; c=relaxed/relaxed;
	bh=6axdt58sY1DqnmVQsW0ISUurcHhysngabrgAEPT5NAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YeDX2SFrx0LPkJ6qtvHZytq9rMUowmFNuuUfvFeZ+D4ZhrpIrhSQg+Y8iFvxWuyWn0vjLWBkt4EhIR3rZdeXfDylaiXFct9aWwyT6zfrI1Zy6WkJ9eBU+QzCIBP5VuniAfgmNmx2KLRcOw7D2O2dNwJPqvU6cw0T4btZaj0wZLujR8tRgLgaZHPsuWoGGi+haaxLyrN5NdfGGpaZFfqq2CvxmaSA3a4HG3461Fkk9kCJNmDJ+jrbzLv9nNxzYw9sGTBGvfdvpkesrt4QrCM6oqkMIsNHePR4CpndHHUJaqTx1nb/53tgsoLytiBmw0jj1ahvFjNagoCLtYJc4COHEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ROdgvEYD; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XRLzIFhj; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ROdgvEYD;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XRLzIFhj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=mukesh.ojha@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZv0T0fSZz2ypW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Sep 2026 06:07:36 +1000 (AEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HrRW52483421
	for <linux-aspeed@lists.ozlabs.org>; Wed, 2 Sep 2026 20:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6axdt58sY1D
	qnmVQsW0ISUurcHhysngabrgAEPT5NAQ=; b=ROdgvEYDb2UZdpNEhI8RxvnS9DG
	2OQurEeIzPojM+T0MtsUy8ud0+ePaKsegGa2jZIAz+1/ZoRDfQgUPhsWM5VI8Q8V
	8njeua6nNI9k3tuL04Wmg+SptShh5D1ZtQpf+Zrhq47/HGQS6EE4cqFFn7skgYwG
	Z8Pah6EzNrX9zEbaBzGCISZoP7dl2XJBkXOqozZ8Zn62ajG2B3LSVEfCueR2Cs2f
	upqOVyaMpNKvUQ2R4tfkN7yAo4cStnJcs3FMv3FGzcqkoiO7mcmY639u/FVsvIeW
	raqcwHlpDp5YDpK9k9328GUmh7ldi700HT5V6eYIPzoxV9f3VRQ2Xz+Btpg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemjh9p73-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:07:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-396b9ef3070so2543771a91.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 13:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788379653; x=1788984453; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6axdt58sY1DqnmVQsW0ISUurcHhysngabrgAEPT5NAQ=;
        b=XRLzIFhjR3z9yEkBmwVZCSjLwv5QVZvYqxPWTWyz66acfX820tsWnydTETXyFnSxHd
         MFCEX0vpYFts0O9XH6uQtHXTuerxxJyC5c1rO4DLpcBY2LbGtXR5pNCUAvko6Za4z65u
         eq77RuUZoXdx0RAqEYMpbC2cC6OF09cfJv5ZY5qGaCvOCs/EliUcJgh3FxlvwF2Lpif8
         oycRbIgSp0+jzPkvaGbXddg82eBHdZq3dsHudU4D6l2KFXEV9nij7+E2tneee3b2BbGb
         Xqm+DA9l/ZxiukMWI1csWEocnupQWKFOhKhfZEO6Sqa28uTZ7QGc5K88wMFUy3ZcYDO0
         X+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788379653; x=1788984453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6axdt58sY1DqnmVQsW0ISUurcHhysngabrgAEPT5NAQ=;
        b=tVOLvLXy+G+m95q2lghy3Yl/PMgDBFdQFqCHq/ACUtD0O1SO2GT0VXYU3uKGWoWUSG
         fq337pbRwPn2d4kBYtCuK01C/sQteh+xSkcAPB/tvdL1GIGNJyKv8J7EEqdnD+/iPnaM
         xq43ZD9060lvA1UwqrCHV1+hTNO1JABv5klh1YOyamlxyhhMrWz1vtDclK+fSxWru3aC
         LZlJBfm9DkSFfbvAqeSxPodxRPh2khWCDaVuqOgdegK6Vg10b94VpsRIPm/QjwjQCCf8
         +bHVZFgnDM5PRHoY5bqpzFnbB16EJyhAknnZRcT0UYOHf+/wZdvMLwOlooLA1F9G7OCk
         N+lg==
X-Forwarded-Encrypted: i=1; AKwUvByfS3FXx588Jrc3aApMolhSt9GFE/26vx34KzOJZKjEy6Ja/GIzgwLaqpVEXqxOH+aZMmnFZpezPrUfcD8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mNhqLFGQOkRUkWxNfVfW+SQqASK/tyGPP2rz6knZv4NJ+oRNcL
	yh2VrVhVjqK1DAEPuwtCEnkIMi+zJ7txXt1boJ2v8ve85IYve4zcyKh++y/XZkD5nyFqI2z7DRB
	5ZawXXU497KXe2FbBokbA7uGYeEmAON164sHV+45TAo8SoJ4fms979MzZodBrDWJhwvC9
X-Gm-Gg: AYBFou3rBjTjj+3JO4K1e5thgnBig81IZktCsqj95wZX+K4/+pFbfXX0Z4Q8pJdZWUH
	XOunf4ft4wpEbe6zCeEjfQVElZDl9cRjKXEnrNJMZugxtcxZwa1PEHTGRJmY3ZpkY4HveVYp08/
	3aCP8qLeWDAa0JauVyUsa1eWKBewKPaVTtlehqLYVbT31czHQvIo8Dz7h+fZwVD3TmfZ2hrCgJG
	LQjp1lT5UyPflDMAiWEvLILE1Iy6s/puf/fdDH8njq5Rs+1ojv0/r3bQm9TU0wCf1c7YyGp1P7d
	FYJgLSdrChQFoXw5JfSgkncyFy7pAKRng38wBzEHLW512EmnDQQeSae4+lxZUOppulUdCFyc93Y
	W4nvXQIYyPcpErb1MvWRJx/Yvn90=
X-Received: by 2002:a17:90a:f94f:b0:398:bacb:1137 with SMTP id 98e67ed59e1d1-39aee21a4demr11942902a91.19.1788379653317;
        Wed, 02 Sep 2026 13:07:33 -0700 (PDT)
X-Received: by 2002:a17:90a:f94f:b0:398:bacb:1137 with SMTP id 98e67ed59e1d1-39aee21a4demr11942802a91.19.1788379652830;
        Wed, 02 Sep 2026 13:07:32 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33255f2981dsm434360eec.19.2026.09.02.13.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 13:07:32 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Daniel Scally <dan.scally@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Joseph Liu <kwliu@nuvoton.com>, Marvin Lin <kflin@nuvoton.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paulk@sys-base.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        linux-staging@lists.linux.dev, linux-sunxi@lists.linux.dev,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 1/6] media: synopsys: hdmirx: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:36:58 +0530
Message-ID: <20260902200703.2016410-2-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902200703.2016410-1-mukesh.ojha@oss.qualcomm.com>
References: <20260902200703.2016410-1-mukesh.ojha@oss.qualcomm.com>
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
X-Proofpoint-GUID: 39EsPe26jhLgWRn3nMy6nlnrUya6GfJH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OCBTYWx0ZWRfX28qDi2NxXcAp
 0lyhqIT4tF/v+uvf87ItXt9Ns32gJLx/si/TxCT5dLIx55xpwRHOl7KAvmOzMA3gFCz/IlG78PM
 5M0QnODEsO+fHqdSYVPAaHUTQFhGSr/dmJWECpzc1UWSf/O6DXfJJ1zy462ITkalMQfL/wU3zyb
 iNgotyiHGwLlflREpgjhEDg/n2jwa08kahG/tMz0DzrrpwQ3BzSyRqy54TnYQd+eh6xpsytl15y
 QNjpSGw9D9E0NgKzrx1QW26Dzf4QjtQN5j43cCJlxP0t0c5C5xErkNDTvdQJpuTHYmhEaYpE735
 PDo+bLBVCnlJQxDzDWJvAMTaUYHPzprg+ksKtUHJ66cwOrz9TJN9LlKUynoKCX60rWKUem6hgfL
 FE8mxpjPIOzqHNoBuA4RY9CXiUqZbYX79Yr9SP0STRWqKkplcq1i7zRhUY+1IpEYZZJqeDfAS/8
 J98eb554pYndQyMfREQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OCBTYWx0ZWRfX/vwjy4nH2axU
 WSAzWSQPkZlMh9fdoamJZS/vngO6vezhTWB1MzzuSBuEtPbFZRN4R2fI2Tt7tQvhb6HpOl+ghck
 B/Ta0jQ2igceZerAKLJFx93Az5EBM74=
X-Authority-Analysis: v=2.4 cv=ErHiaycA c=1 sm=1 tr=0 ts=6a988206 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=QX4gbG5DAAAA:8
 a=EUspDBNiAAAA:8 a=wxxTr_YEz1i4iFEBgi8A:9 a=rl5im9kqc5Lf4LNbBjHf:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: 39EsPe26jhLgWRn3nMy6nlnrUya6GfJH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020178

Replace the hand-rolled devm_hdmirx_of_reserved_mem_device_release()
devres action with devm_of_reserved_mem_device_init(), which handles the
cleanup automatically. This removes both the wrapper function and the
devm_add_action_or_reset() call.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 .../media/platform/synopsys/hdmirx/snps_hdmirx.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
index 25f8ca0d6d94..7c6acc6d7e88 100644
--- a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
+++ b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
@@ -2265,11 +2265,6 @@ static const struct hdmirx_cec_ops hdmirx_cec_ops = {
 	.read = hdmirx_readl,
 };
 
-static void devm_hdmirx_of_reserved_mem_device_release(void *dev)
-{
-	of_reserved_mem_device_release(dev);
-}
-
 static int hdmirx_parse_dt(struct snps_hdmirx_dev *hdmirx_dev)
 {
 	struct device *dev = hdmirx_dev->dev;
@@ -2316,16 +2311,9 @@ static int hdmirx_parse_dt(struct snps_hdmirx_dev *hdmirx_dev)
 	if (!device_property_read_bool(dev, "hpd-is-active-low"))
 		hdmirx_dev->hpd_trigger_level_high = true;
 
-	ret = of_reserved_mem_device_init(dev);
-	if (ret) {
+	ret = devm_of_reserved_mem_device_init(dev);
+	if (ret)
 		dev_warn(dev, "no reserved memory for HDMIRX, use default CMA\n");
-	} else {
-		ret = devm_add_action_or_reset(dev,
-					       devm_hdmirx_of_reserved_mem_device_release,
-					       dev);
-		if (ret)
-			return ret;
-	}
 
 	return 0;
 }
-- 
2.55.0


