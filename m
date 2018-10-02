From: Vijay Khemka <vijaykhemka@fb.com>
Date: Tue, 2 Oct 2018 21:34:57 +0000
Subject: [PATCH v2] net/ncsi: Add NCSI OEM command support
In-Reply-To: <3dc1e3c74a864c3da7aaf19c3ca9edfa@AUSX13MPS306.AMER.DELL.COM>
References: <20180929010602.1025909-1-vijaykhemka@fb.com>
 <1004987ef0ab138e772ed5740a0d839bffe39910.camel@mendozajonas.com>
 <4876838166d140bab331280efcfd771d@AUSX13MPS306.AMER.DELL.COM>
 <F932552B-5751-48E9-BC8B-6F9D7841C7FA@fb.com>
 <3dc1e3c74a864c3da7aaf19c3ca9edfa@AUSX13MPS306.AMER.DELL.COM>
Message-ID: <4F2DCF80-A0D8-4475-9777-72CFCA037BEC@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Justin,
Please see comments below

-Vijay
 
    > > > diff --git a/net/ncsi/ncsi-cmd.c b/net/ncsi/ncsi-cmd.c
    > > > index 7567ca63aae2..2f98533eba46 100644
    > > > --- a/net/ncsi/ncsi-cmd.c
    > > > +++ b/net/ncsi/ncsi-cmd.c
    > > > @@ -211,6 +211,26 @@ static int ncsi_cmd_handler_snfc(struct sk_buff *skb,
    > > >  	return 0;
    > > >  }
    > > >  
    > > > +static int ncsi_cmd_handler_oem(struct sk_buff *skb,
    > > > +				struct ncsi_cmd_arg *nca)
    > > > +{
    > > > +	struct ncsi_cmd_oem_pkt *cmd;
    > 
    > >OEM command doesn't not have the fixed data size. Should we use pointer instead?
    > >struct ncsi_cmd_oem_pkt {
    > >	struct ncsi_cmd_pkt_hdr cmd;         /* Command header    */
    > >	__be32                  mfr_id;      /* Manufacture ID    */
    > >	unsigned char           *data;       /* OEM Payload Data  */
    > >};
    > Yes, I agree that OEM command doesn't have fixed data but to map to skbuff structure, 
    > I have defined above structure as per NCSI spec, We can certainly have a MAX_DATA_LEN define.
    
    The spec only defines manufacture ID field and the start offset of vendor data. 
    If we just want to point to the vendor data, we don't need to specify the max length and
    we can use flexible array as the last member (correct the typo above).
    
    struct ncsi_cmd_oem_pkt {
    	struct ncsi_cmd_pkt_hdr cmd;         /* Command header    */
    	__be32                  mfr_id;      /* Manufacture ID    */
    	unsigned char           data[];       /* OEM Payload Data  */
    };

I agree and will add this change.
     
    > > > +	unsigned int len;
    > > > +
    > > > +	len = sizeof(struct ncsi_cmd_pkt_hdr) + 4;
    > > > +	if (nca->payload < 26)
    > > > +		len += 26;
    > 
    > >Why does it add 26? I knew the other place in ncsi_alloc_command() is also add 26.
    > >If it is less than 26, then it should be a fixed size of structure ncsi_cmd_pkt (46), right?
    > It adds 26 because It has already assigned len to hdr+4 which is 16+4 = 20 bytes. By 
    > adding 26 it makes it to 46. I am just being consistent with other portion of code.
    > 
    > > > +	else
    > > > +		len += nca->payload;
    > > > +
    > > > +	cmd = skb_put_zero(skb, len);
    > > > +	cmd->mfr_id = nca->dwords[0];
    > > > +	memcpy(cmd->data, &nca->dwords[1], nca->payload - 4);
    > 
    > >Netlink request is using the new nca->data pointer to pass the data as the request payload
    > >is not the same size and some command payload is bigger than 16 bytes.
    > >Will you consider to use the same data pointer? So, we don't need to have a checking here.
    > >If the command is used less than 16 bytes, we can simply assigned &nca->bytes[0] to it.
    > To keep original structure, we can change 16 bytes to MAX_DATA_LEN. Or I don't see any issue in 
    > Copying data from data pointer from nca but user needs to be aware if it is less than 16 bytes then 
    > use bytes or use data pointer. To keep it simple, we should simply define MAX_LEN.
    
    I use the pointer to avoid copying the data again. OEM handler can always process the flexible payload
    through the data pointer. It can depend on the caller to use stack/allocated buffer/nca buffer and
    it will be straight forward if all OEM stuff is using the data pointer to process the flexible
    payload.

Do we use data pointer for payload less than 16 bytes as well in OEM. We copy data only once while adding to skbuff. 
I have no issue, I will make this change but wait for other comments.
    
    > 
    > > > diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
    > > > index 91b4b66438df..1f338386810d 100644
    > > > --- a/net/ncsi/ncsi-pkt.h
    > > > +++ b/net/ncsi/ncsi-pkt.h
    > > > @@ -151,6 +151,22 @@ struct ncsi_cmd_snfc_pkt {
    > > >  	unsigned char           pad[22];
    > > >  };
    > > >  
    > > > +/* OEM Request Command as per NCSI Specification */
    > > > +struct ncsi_cmd_oem_pkt {
    > > > +	struct ncsi_cmd_pkt_hdr cmd;         /* Command header    */
    > > > +	__be32                  mfr_id;      /* Manufacture ID    */
    > > > +	unsigned char           data[64];    /* OEM Payload Data  */
    > > > +	__be32                  checksum;    /* Checksum          */
    > > > +};
    > > > +
    > > > +/* OEM Response Packet as per NCSI Specification */
    > > > +struct ncsi_rsp_oem_pkt {
    > > > +	struct ncsi_rsp_pkt_hdr rsp;         /* Command header    */
    > > > +	__be32                  mfr_id;      /* Manufacture ID    */
    > > > +	unsigned char           data[64];    /* Payload data      */
    > > > +	__be32                  checksum;    /* Checksum          */
    > > > +};
    > > > +
    > 
    > >OEM command doesn't not have the fixed response data size too.
    > >Should we use pointer instead?
    > 
    > Here also we can define MAX_DATA_LEN because data pointer won't map to skb directly.
    
    Suggest to change as below due to the flexible response.
    struct ncsi_rsp_oem_pkt {
    	struct ncsi_rsp_pkt_hdr rsp;         /* Command header    */
    	__be32                  mfr_id;      /* Manufacture ID    */
    	unsigned char           data[];    /* Payload data      */
    };
    
Sure done.

